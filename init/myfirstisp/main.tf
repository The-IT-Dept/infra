locals {
  dns_zone = "isp.theitdept.au"

  github_org    = "the-it-dept"
  github_repo   = "infra"
  github_branch = "main"
  flux_path     = "k8s/myfirstisp/base"

  networks = {
    vlan100 = {
      model        = "virtio",
      bridge       = "vmbr0",
      tag          = 100,
      ipv4_netmask = "24"
      ipv4_gateway = "172.24.0.254"
    }
  }

  common = {
    target_node = "hv01"
    pool        = "k8s-myfirstisp"
    cores       = 4
    sockets     = 4
    balloon     = 1024
    memory      = 8192
    storage = [
      {
        size    = "32G",
        type    = "scsi",
        storage = "ssd-store",
      },
      {
        size    = "200G",
        type    = "scsi",
        storage = "ssd-store",
      }
    ]
  }

  machines = {
    master-0 = merge(local.common, {
      network = [
        merge(local.networks.vlan100, {
          ipv4_address = "172.24.0.15"
        })
      ]
    }),
    master-1 = merge(local.common, {
      network = [
        merge(local.networks.vlan100, {
          ipv4_address = "172.24.0.16"
        })
      ]
    }),
    master-2 = merge(local.common, {
      network = [
        merge(local.networks.vlan100, {
          ipv4_address = "172.24.0.17"
        })
      ]
    }),
  }
}