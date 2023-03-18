resource "tls_private_key" "flux" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "github_repository_deploy_key" "this" {
  title      = "Flux"
  repository = local.github_repo
  key        = tls_private_key.flux.public_key_openssh
  read_only  = "false"
}

provider "flux" {
  kubernetes = {
    host                   = module.k3s.kubernetes.api_endpoint
    cluster_ca_certificate = module.k3s.kubernetes.cluster_ca_certificate
    client_certificate     = module.k3s.kubernetes.client_certificate
    client_key             = module.k3s.kubernetes.client_key
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
