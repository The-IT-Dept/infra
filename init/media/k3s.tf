module "k3s" {
  source = "github.com/xunleii/terraform-module-k3s?ref=724400c6535f20494cc9f09dc5970f151a9ce7ff"

  depends_on = [module.virtual_machine]

  k3s_version    = "latest"
  use_sudo       = true
  cluster_domain = "cluster.local"

  cidr = {
    pods     = "10.42.0.0/16"
    services = "10.43.0.0/16"
  }

  drain_timeout  = "90s"
  managed_fields = ["label", "taint"]

  global_flags = [
    "--tls-san media.theitdept.au",
    "--flannel-iface ens160",
  ]

  servers = {
    for name, machine in local.machines : name => {
      ip = machine.network[0].ipv4_address

      connection = {
        user        = "sysadmin",
        host        = machine.network[0].ipv4_address
        private_key = tls_private_key.ssh_key.private_key_pem
      },

      flags = [
        "--disable traefik", "--disable servicelb", "--disable-network-policy",
        "--flannel-iface=eth0"
      ]
      labels = { "node.kubernetes.io/type" = "master" }
    }
  }

}

resource "local_sensitive_file" "kubeconfig" {
  depends_on = [module.k3s]
  filename   = "${path.module}/.kube/${local.cluster_name}.yaml"
  content    = replace(module.k3s.kube_config, "https://.*?:6443", "https://${local.cluster_name}:6443")
}
