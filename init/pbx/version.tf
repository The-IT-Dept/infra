terraform {
  required_providers {
    external = {
      source  = "hashicorp/external"
      version = ">=2.3.1"
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
