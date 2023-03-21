variable "template" {
  type    = string
  default = "The name of the template to use for the instance."
}

variable "ssh_keys" {
  default     = []
  type        = list(string)
  description = "Additional SSH Keys to add to the instances"
}

variable "ciuser" {
  default     = "sysadmin"
  type        = string
  description = "The Cloud Init Username"
}

variable "machines" {
  type = map(object({
    id          = optional(number)
    target_node = optional(string)
    pool        = optional(string)
    cores       = optional(number)
    sockets     = optional(number)
    balloon     = optional(number)
    memory      = optional(number)

    storage = optional(list(object({
      slot    = optional(number)
      size    = optional(string)
      type    = optional(string)
      storage = optional(string)
      ssd     = optional(number)
    })))

    network = optional(list(object({
      ipv4_address = optional(string)
      ipv4_gateway = optional(string)
      ipv4_netmask = optional(string)
      ipv6_address = optional(string)
      ipv6_gateway = optional(string)
      ipv6_netmask = optional(string)
      model        = optional(string)
      mtu          = optional(number)
      macaddr      = optional(string)
      bridge       = optional(string)
      tag          = optional(number)
      firewall     = optional(bool)
      link_down    = optional(bool)
    })))

  }))

  default = {

  }
  description = "Identifies the object of virtual machines."
}

variable "dns_zone" {
  type        = string
  default     = ""
  description = "Local DNS zone."
}

variable "dns_servers" {
  type        = list(string)
  default     = []
  description = "list of up to 3 DNS resolvers."

  validation {
    condition     = length(var.dns_servers) > 0
    error_message = "The dns_servers variable must contain at least 1 DNS server."
  }

  validation {
    condition     = length(var.dns_servers) <= 3
    error_message = "The dns_servers variable can only contain up to 3 DNS servers."
  }
}

variable "pm_api_url" {
  type        = string
  default     = ""
  description = "Proxmox host."
}

variable "pm_api_token_id" {
  type        = string
  default     = ""
  description = "Proxmox API Token ID"
  sensitive   = true
}

variable "pm_api_token_secret" {
  type        = string
  default     = ""
  description = "Proxmox API Key"
  sensitive   = true
}
