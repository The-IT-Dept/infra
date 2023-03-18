module "k3s" {
  source = "github.com/djh00t/terraform-module-k3s?ref=5c5fdecc0280e0a75d6fb118395247102c0d232a"

  depends_on = [module.virtual_machine]

  k3s_version    = "v1.26.1+k3s1"
  use_sudo       = true
  cluster_domain = "cluster.local"

  cidr = {
    pods     = "10.254.0.0/16"
    services = "10.255.0.0/24"
  }

  drain_timeout  = "30s"
  managed_fields = ["label", "taint"]

  servers = {
    for name, machine in local.machines : name => {
      ip = split("/", machine.network_0_ip_cidr)[0]

      connection = {
        user        = "sysadmin",
        host        = split("/", machine.network_0_ip_cidr)[0]
        private_key = module.virtual_machine.virtual_machine_private_key
      },
      flags = [
        "--disable traefik", "--disable servicelb", "--disable-network-policy",
        "--flannel-iface=eth0"
      ]
      labels = { "node.kubernetes.io/type" = "master" }
    }
  }
}
