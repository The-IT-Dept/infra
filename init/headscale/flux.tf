resource "flux_bootstrap_git" "this" {
  depends_on = [module.k3s, github_repository_deploy_key.this]

  path = "k8s/headscale/base"
}
