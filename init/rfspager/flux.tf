resource "flux_bootstrap_git" "this" {
  depends_on = [module.k3s, github_repository_deploy_key.this]

  path = local.flux_path
}
