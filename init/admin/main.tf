locals {
  github_org    = "the-it-dept"
  github_repo   = "infra"
  github_branch = "main"

  cluster_name = "admin.theitdept.au"
  k3s_host     = "admin.theitdept.au"
  k3s_version  = "v1.26.2+k3s1"
  flux_path    = "k8s/admin/base"
}
