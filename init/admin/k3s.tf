module "k3s" {
  source = "github.com/djh00t/terraform-module-k3s?ref=5c5fdecc0280e0a75d6fb118395247102c0d232a"

  k3s_version    = local.k3s_version
  use_sudo       = true
  cluster_domain = local.cluster_name

  cidr = {
    pods     = "10.42.0.0/16"
    services = "10.43.0.0/16"
  }

  drain_timeout  = "90s"
  managed_fields = ["label", "taint"]

  global_flags = [
    "--tls-san ${local.k3s_host}",
    "--flannel-iface ens160",
  ]

  servers = {
    "master-0" = {
      ip = "27.50.64.156"
      connection = {
        user        = "root",
        host        = local.k3s_host,
        private_key = file("~/.ssh/id_rsa")
      },
      flags = [
        "--flannel-iface=ens160"
      ]
      labels = { "node.kubernetes.io/type" = "master" }
    }
  }
}
