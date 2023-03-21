terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
    flux = {
      source  = "fluxcd/flux"
      version = ">=0.24.2"
    }
    github = {
      source  = "integrations/github"
      version = ">=5.18.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">=4.0.4"
    }
    external = {
      source  = "hashicorp/external"
      version = ">=2.3.1"
    }
  }
}

data "external" "env" {
  program = ["${path.module}/../env.sh"]
}
