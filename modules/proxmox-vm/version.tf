terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.11"
      # 2.9.13 was buggy, .12 didn't exist
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 3.3.0"
    }
  }
  required_version = ">= 0.13"
}

provider "proxmox" {
  # URL to access proxmox API
  pm_api_url = var.pm_api_url

  # api token id is in the form of: <username>@pam!<tokenId>
  pm_api_token_id = var.pm_api_token_id

  # this is the full secret wrapped in quotes. don't worry, I've already deleted this from my proxmox cluster by the time you read this post
  pm_api_token_secret = var.pm_api_token_secret

  # leave tls_insecure set to true unless you have your proxmox SSL certificate situation fully sorted out (if you do, you will know)
  pm_tls_insecure = true

  # This is the number of parallel requests to make to the proxmox API. I've found that 2 is a good number.
  # For production workloads - only choose as many workers as you can afford hosts to be offline at any one time.
  pm_parallel = 6

  # Logging/Debug
  # this is just for debugging. set to false when you are done
  pm_debug      = false
  pm_log_enable = false
  pm_log_file   = "terraform-plugin-proxmox.log"
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
}