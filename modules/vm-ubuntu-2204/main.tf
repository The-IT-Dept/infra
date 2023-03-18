resource "tls_private_key" "virtual_machine_keys" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "proxmox_vm_qemu" "virtual_machines" {
  depends_on = [
    tls_private_key.virtual_machine_keys
  ]

  for_each = var.machines
  #vmid             = each.value.id
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

  ciuser  = "sysadmin"
  sshkeys = join("\r\n", concat([chomp(tls_private_key.virtual_machine_keys.public_key_openssh)], var.ssh_keys))

  ipconfig0    = "ip=${each.value.network_0_ip_cidr},gw=${each.value.network_0_ip_gw}"
  searchdomain = var.dns_zone
  nameserver   = "1.1.1.1 8.8.8.8"


  disk {
    slot    = 0
    size    = each.value.storage_0_size
    type    = "scsi"
    storage = each.value.storage_0_dev
    ssd     = 1
  }

  network {
    bridge    = each.value.network_0_bridge
    tag       = each.value.network_0_tag
    model     = "virtio"
    firewall  = each.value.network_0_firewall
    link_down = each.value.network_0_link_down
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update", "apt upgrade -y", "echo Done!"
    ]

    connection {
      host        = split("/", each.value.network_0_ip_cidr)[0]
      type        = "ssh"
      user        = "sysadmin"
      private_key = tls_private_key.virtual_machine_keys.private_key_pem
    }
  }
}
