locals {
  github_org    = "the-it-dept"
  github_repo   = "infra"
  github_branch = "main"
  flux_path     = "k8s/staging.syd.node.net.au/base"



  cluster_name = "staging.syd.node.net.au"
  k3s_host     = "staging.syd.node.net.au"
  k3s_version  = "v1.28.5+k3s1"
  kubeconfig   = "~/.kube/staging.syd.node.net.au.yaml"
}
