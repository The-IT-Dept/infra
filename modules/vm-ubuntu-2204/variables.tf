variable "template" {
  type = string
  default = "The name of the template to use for the instance."
}

variable "ssh_keys" {
  default = []
  type  = list(string)
  description = "Additional SSH Keys to add to the instances"
}

variable "machines" {
  type = map(object({
    # id          = number
    target_node = string
    pool        = string
    cores       = number
    socket     = number
    balloon      = number
    memory      = number

    storage_0_size   = string
    storage_0_dev    = string

    network_0_ip_gw     = string
    network_0_ip_cidr   = string
    network_0_bridge    = string
    network_0_tag       = number
    network_0_firewall  = bool
    network_0_link_down = bool

  }))
  default     = {}
  description = "Identifies the object of virtual machines."
}

variable "dns_zone" {
  type        = string
  default     = ""
  description = "Local DNS zone."
}

variable "pm_api_url" {
  type        = string
  default     = "https://hv01:8006/api2/json"
  description = "Proxmox host."
}

variable "pm_api_token_id" {
  type        = string
  default     = ""
  description = "Proxmox API key"
  sensitive = true
}

variable "pm_api_token_secret" {
  type        = string
  default     = ""
  description = "Proxmox API key"
  sensitive = true
}