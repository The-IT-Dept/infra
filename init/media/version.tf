terraform {
  required_providers {
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
  }
}

data "external" "env" {
  program = ["${path.module}/../env.sh"]
}

provider "github" {
  owner = local.github_org
  token = data.external.env.result["GITHUB_TOKEN"]
}
