locals {
  dns_zone = "node.net.au"

  github_org    = "the-it-dept"
  github_repo   = "infra"
  github_branch = "main"
  flux_path     = "k8s/node.net.au/base"

  networks = {
    vlan10 = {
      model        = "virtio",
      bridge       = "vmbr0",
      tag          = 10,
      ipv4_netmask = "24"
      ipv4_gateway = "44.136.159.17"
      ipv6_netmask = "64"
      ipv6_gateway = "2001:df3:a00:1::1"
    }
  }

  common = {
    target_node = "hv01"
    pool        = "k8s-node.net.au"
    bootdisk    = "scsi0"
    cores       = 4
    sockets     = 4
    balloon     = 4096
    memory      = 16384
    storage = [
      {
        size    = "32G",
        type    = "scsi",
        storage = "ssd-store",
      },
      {
        size    = "200G",
        type    = "virtio",
        storage = "ssd-store",
      },
      {
        size    = "200G",
        type    = "virtio",
        storage = "ssd-store",
      }
    ]
  }

  machines = {
    master-0 = merge(local.common, {
      network = [
        merge(local.networks.vlan10, {
          ipv4_address = "44.136.159.20"
          ipv6_address = "2001:df3:a00:1::3"
        })
      ]
    }),

    master-1 = merge(local.common, {
      network = [
        merge(local.networks.vlan10, {
          ipv4_address = "44.136.159.21"
          ipv6_address = "2001:df3:a00:1::4"
        })
      ]
    })

    master-2 = merge(local.common, {
      network = [
        merge(local.networks.vlan10, {
          ipv4_address = "44.136.159.22"
          ipv6_address = "2001:df3:a00:1::5"
        })
      ]
    })
  }
}
