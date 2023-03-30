data "sops_file" "github_secrets" {
  source_file = "action-secrets.sops.yaml"
}
