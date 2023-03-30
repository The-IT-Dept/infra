locals {
  github_org = "The-IT-Dept"
}

resource "github_actions_secret" "rfspager-app" {
  for_each = toset([
    "BOT_APP_ID", "BOT_APP_PRIVATE_KEY", "EXPO_TOKEN", "EXPO_ASC_KEY_ID", "EXPO_ASC_API_KEY", "EXPO_ASC_ISSUER_ID",
    "EXPO_APPLE_TEAM_ID", "EXPO_APPLE_TEAM_TYPE",
  ])

  repository      = "rfspager-app"
  secret_name     = each.value
  plaintext_value = data.sops_file.github_secrets.data["data.${each.value}"]
}
