module "k3s" {
  source = "github.com/djh00t/terraform-module-k3s?ref=5c5fdecc0280e0a75d6fb118395247102c0d232a"

  k3s_version    = "v1.26.2+k3s1"
  use_sudo       = true
  cluster_domain = "cluster.local"

  cidr = {
    pods     = "10.42.0.0/16"
    services = "10.43.0.0/16"
  }

  drain_timeout  = "30s"
  managed_fields = ["label", "taint"]

  global_flags = [
    "--tls-san ts.theitdept.au",
    "--flannel-iface ens160",
  ]

  servers = {
    "master-0" = {
      ip = "27.50.64.156"
      connection = {
        user        = "root",
        host        = "ts.theitdept.au",
        private_key = file("~/.ssh/id_rsa")
      },
      flags = [
        "--flannel-iface=ens160"
      ]
      labels = { "node.kubernetes.io/type" = "master" }
    }
  }
}
