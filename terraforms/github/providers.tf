terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
    sops = {
      source  = "carlpett/sops"
      version = "0.7.2"
    }

    external = {
      source  = "hashicorp/external"
      version = ">=2.3.1"
    }

    github = {
      source  = "integrations/github"
      version = ">=5.18.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = ">=4.0.4"
    }

    null = {
      source  = "hashicorp/null"
      version = ">=3.2.1"
    }
  }
}

data "external" "env" {
  program = ["${path.module}/../../init/env.sh"]
}

provider "github" {
  owner = local.github_org
  token = data.external.env.result["GITHUB_TOKEN"]
}

provider "sops" {
}
