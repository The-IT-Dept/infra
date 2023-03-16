locals {
  github_org    = "the-it-dept"
  github_repo   = "infra"
  github_branch = "main"

  common_machine_settings = {
    target_node         = "hv01"
    pool                = "k8s-media"
    cores               = 4
    socket              = 4
    balloon             = 1024
    memory              = 8192
    storage_0_size      = "32G"
    storage_0_dev       = "ssd-store"
    network_0_ip_gw     = "172.24.0.254"
    network_0_bridge    = "vmbr0"
    network_0_tag       = 100
    network_0_firewall  = false
    network_0_link_down = false
  }

  machine_map = {
    machines = {
      master-0 = merge(local.common_machine_settings, {
        network_0_ip_cidr = "172.24.0.10/24"
      })
      master-1 = merge(local.common_machine_settings, {
        network_0_ip_cidr = "172.24.0.11/24"
      })
      master-2 = merge(local.common_machine_settings, {
        network_0_ip_cidr = "172.24.0.12/24"
      })
    }
  }

  machines = lookup(local.machine_map, "machines", {})
}
