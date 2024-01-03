module "k3s" {
  source = "github.com/djh00t/terraform-module-k3s?ref=5c5fdecc0280e0a75d6fb118395247102c0d232a"

  k3s_version    = local.k3s_version
  use_sudo       = true
  cluster_domain = "cluster.local"

  cidr = {
    pods     = "10.42.0.0/16"
    services = "10.43.0.0/16"
  }

  drain_timeout  = "90s"
  managed_fields = ["label", "taint"]

  global_flags = [
    "--tls-san ${local.k3s_host}",
    "--flannel-iface enp0s6",
  ]

  servers = {
    "master-0" = {
      ip = "192.9.181.14"
      connection = {
        user        = "ubuntu",
        host        = local.k3s_host,
        private_key = file("~/.ssh/id_rsa")
      },
      flags = [
        "--flannel-iface=enp0s6"
      ]
      labels = { "node.kubernetes.io/type" = "master" }
    }
  }
}
