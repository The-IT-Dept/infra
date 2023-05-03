locals {
  github_org    = "the-it-dept"
  github_repo   = "infra"
  github_branch = "main"
  flux_path     = "k8s/rfspager/base"

  cluster_name = "rfspager.app"
  k3s_host     = "k8s.rfspager.app"
  k3s_version  = "v1.27.1+k3s1"

}
