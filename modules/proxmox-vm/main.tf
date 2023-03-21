resource "proxmox_vm_qemu" "virtual_machines" {
  for_each         = var.machines
  vmid             = can(each.value.id) ? each.value.id : null
  name             = "${each.key}.${var.dns_zone}"
  desc             = "${each.key}.${var.dns_zone}"
  qemu_os          = "l26"        # Type of Operating System
  os_type          = "cloud-init" # Set to cloud-init to utilize templates
  agent            = 1
  full_clone       = false
  clone            = var.template # Name of Template Used to Clone
  pool             = each.value.pool
  hotplug          = "network,disk,usb"
  numa             = true
  bootdisk         = "virtio0"
  target_node      = each.value.target_node
  memory           = each.value.memory
  balloon          = each.value.balloon
  sockets          = each.value.socket
  cores            = each.value.cores
  oncreate         = true
  onboot           = true
  automatic_reboot = true

  ciuser  = var.ciuser
  sshkeys = join("\r\n", var.ssh_keys)

  searchdomain = var.dns_zone
  nameserver   = var.dns_server

  dynamic "disk" {
    for_each = try(length(each.value.storage), 0) > 0 ? each.value.storage : []
    content {
      slot    = can(disk.value.slot) ? disk.value.slot : disk.key
      size    = can(disk.value.size) ? disk.value.size : "32G"
      type    = can(disk.value.type) ? disk.value.type : "virtio"
      storage = can(disk.value.storage) ? disk.value.storage : "local"
      ssd     = can(disk.value.ssd) ? disk.value.ssd : 0
    }
  }

  dynamic "network" {
    for_each = try(length(each.value.network), 0) > 0 ? each.value.network : []
    content {
      model     = can(network.value.model) ? network.value.model : "virtio"
      bridge    = can(network.value.bridge) ? network.value.bridge : "vmbr0"
      tag       = can(network.value.tag) ? network.value.tag : null
      mtu       = can(network.value.mtu) ? network.value.mtu : 1500
      macaddr   = can(network.value.macaddr) ? network.value.macaddr : null
      firewall  = can(network.value.firewall) ? network.value.firewall : true
      link_down = can(network.value.link_down) ? network.value.link_down : false
    }
  }

  ipconfig0 = can(each.value.network[0]) ? join(
    ",",
    compact([
      try(each.value.network[0].ipv4_address != null) ? "ip=${each.value.network[0].ipv4_address}/${each.value.network[0].ipv4_netmask}" : null,
      try(each.value.network[0].ipv4_gateway != null) ? "gw=${each.value.network[0].ipv4_gateway}" : null,
      try(each.value.network[0].ipv6_address != null) ? "ip6=${each.value.network[0].ipv6_address}/${each.value.network[0].ipv6_netmask}" : null,
      try(each.value.network[0].ipv6_gateway != null) ? "gw6=${each.value.network[0].ipv6_gateway}" : null,
    ])
  ) : null

  ipconfig1 = can(each.value.network[1]) ? join(
    ",",
    compact([
      try(each.value.network[1].ipv4_address != null) ? "ip=${each.value.network[1].ipv4_address}/${each.value.network[1].ipv4_netmask}" : null,
      try(each.value.network[1].ipv4_gateway != null) ? "gw=${each.value.network[1].ipv4_gateway}" : null,
      try(each.value.network[1].ipv6_address != null) ? "ip6=${each.value.network[1].ipv6_address}/${each.value.network[1].ipv6_netmask}" : null,
      try(each.value.network[1].ipv6_gateway != null) ? "gw6=${each.value.network[1].ipv6_gateway}" : null,
    ])
  ) : null

  ipconfig2 = can(each.value.network[2]) ? join(
    ",",
    compact([
      try(each.value.network[2].ipv4_address != null) ? "ip=${each.value.network[2].ipv4_address}/${each.value.network[2].ipv4_netmask}" : null,
      try(each.value.network[2].ipv4_gateway != null) ? "gw=${each.value.network[2].ipv4_gateway}" : null,
      try(each.value.network[2].ipv6_address != null) ? "ip6=${each.value.network[2].ipv6_address}/${each.value.network[2].ipv6_netmask}" : null,
      try(each.value.network[2].ipv6_gateway != null) ? "gw6=${each.value.network[2].ipv6_gateway}" : null,
    ])
  ) : null

  ipconfig3 = can(each.value.network[3]) ? join(
    ",",
    compact([
      try(each.value.network[3].ipv4_address != null) ? "ip=${each.value.network[3].ipv4_address}/${each.value.network[3].ipv4_netmask}" : null,
      try(each.value.network[3].ipv4_gateway != null) ? "gw=${each.value.network[3].ipv4_gateway}" : null,
      try(each.value.network[3].ipv6_address != null) ? "ip6=${each.value.network[3].ipv6_address}/${each.value.network[3].ipv6_netmask}" : null,
      try(each.value.network[3].ipv6_gateway != null) ? "gw6=${each.value.network[3].ipv6_gateway}" : null,
    ])
  ) : null

  ipconfig4 = can(each.value.network[4]) ? join(
    ",",
    compact([
      try(each.value.network[4].ipv4_address != null) ? "ip=${each.value.network[4].ipv4_address}/${each.value.network[4].ipv4_netmask}" : null,
      try(each.value.network[4].ipv4_gateway != null) ? "gw=${each.value.network[4].ipv4_gateway}" : null,
      try(each.value.network[4].ipv6_address != null) ? "ip6=${each.value.network[4].ipv6_address}/${each.value.network[4].ipv6_netmask}" : null,
      try(each.value.network[4].ipv6_gateway != null) ? "gw6=${each.value.network[4].ipv6_gateway}" : null,
    ])
  ) : null
}