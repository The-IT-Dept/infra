terraform {
  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "0.7.2"
    }

    external = {
      source  = "hashicorp/external"
      version = ">=2.3.1"
    }

    flux = {
      source  = "fluxcd/flux"
      version = ">=0.24.2"
    }

    kind = {
      source  = "tehcyx/kind"
      version = ">=0.0.16"
    }

    github = {
      source  = "integrations/github"
      version = ">=5.18.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = ">=4.0.4"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">=2.18.1"
    }
  }
}

data "external" "env" {
  program = ["${path.module}/../env.sh"]
}

provider "github" {
  owner = local.github_org
  token = data.external.env.result["GITHUB_TOKEN"]
}

provider "sops" {
}

provider "kubernetes" {
  config_path = local.kubeconfig
}

provider "flux" {
  kubernetes = {
    config_path = local.kubeconfig
  }

  git = {
    url    = "ssh://git@github.com/${local.github_org}/${local.github_repo}.git"
    branch = local.github_branch
    ssh = {
      username    = "git"
      private_key = tls_private_key.flux.private_key_pem
    }
  }
}
