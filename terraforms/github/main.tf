locals {
  github_org = "The-IT-Dept"
}

resource "github_actions_secret" "rfspager" {
  for_each = toset([
    "BOT_APP_ID", "BOT_APP_PRIVATE_KEY"
  ])

  repository      = "rfspager"
  secret_name     = each.value
  plaintext_value = data.sops_file.github_secrets.data["data.${each.value}"]
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

resource "github_actions_secret" "rfspager-backend" {
  for_each = toset([
    "BOT_APP_ID", "BOT_APP_PRIVATE_KEY", "DEPLOY_SSH_KEY", "COMPOSER_AUTH", "FONTAWESOME_NPM_AUTH_TOKEN"
  ])

  repository      = "rfspager-backend"
  secret_name     = each.value
  plaintext_value = data.sops_file.github_secrets.data["data.${each.value}"]
}

resource "github_actions_secret" "stores" {
  for_each = toset([
    "BOT_APP_ID", "BOT_APP_PRIVATE_KEY", "DEPLOY_SSH_KEY", "COMPOSER_AUTH", "FONTAWESOME_NPM_AUTH_TOKEN"
  ])

  repository      = "stores"
  secret_name     = each.value
  plaintext_value = data.sops_file.github_secrets.data["data.${each.value}"]
}

resource "github_actions_secret" "tilly-and-milly-tracking" {
  for_each = toset([
    "BOT_APP_ID", "BOT_APP_PRIVATE_KEY", "DEPLOY_SSH_KEY", "COMPOSER_AUTH", "FONTAWESOME_NPM_AUTH_TOKEN"
  ])

  repository      = "tilly-and-milly-tracking"
  secret_name     = each.value
  plaintext_value = data.sops_file.github_secrets.data["data.${each.value}"]
}

resource "github_actions_secret" "node-isp" {
  for_each = toset([
    "BOT_APP_ID", "BOT_APP_PRIVATE_KEY", "COMPOSER_AUTH", "FONTAWESOME_NPM_AUTH_TOKEN"
  ])

  repository      = "node-isp"
  secret_name     = each.value
  plaintext_value = data.sops_file.github_secrets.data["data.${each.value}"]
}
