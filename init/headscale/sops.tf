data "sops_file" "sops-age-secret" {
  depends_on  = [flux_bootstrap_git.this]
  source_file = "sops-age.sops.yaml"
}

resource "kubernetes_secret" "sops-age" {
  metadata {
    namespace = "flux-system"
    name      = "sops-age"
  }
  data = {
    "age.agekey" = data.sops_file.sops-age-secret.data["data.age.agekey"]
  }
}
