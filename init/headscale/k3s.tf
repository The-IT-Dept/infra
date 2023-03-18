module "k3s" {
  source = "github.com/djh00t/terraform-module-k3s?ref=5c5fdecc0280e0a75d6fb118395247102c0d232a"

  k3s_version    = "v1.26.2+k3s1"
  use_sudo       = true
  cluster_domain = "cluster.local"

  cidr = {
    pods     = "10.42.0.0/16,2001:cafe:42:0::/56"
    services = "10.43.0.0/16,2001:cafe:42:1::/112"
  }

  drain_timeout  = "30s"
  managed_fields = ["label", "taint"]

  servers = {
    "master-0" = {
      ip = "hs.theitdept.au"
      connection = {
        user        = "root",
        host        = "hs.theitdept.au",
        private_key = file("~/.ssh/id_rsa")
      },
      flags = [
        "--flannel-iface=eth0"
      ]
      labels = { "node.kubernetes.io/type" = "master" }
    }
  }
}
