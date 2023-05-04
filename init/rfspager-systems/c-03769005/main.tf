locals {
  github_org    = "the-it-dept"
  github_repo   = "infra"
  github_branch = "main"
  flux_path     = "k8s/rfspager-systems/c-03769005/base"

  cluster_name = "c-03769005.rfspager.app"
  kubeconfig   = "~/.kube/c-03769005.rfspager.app.yaml"
}
