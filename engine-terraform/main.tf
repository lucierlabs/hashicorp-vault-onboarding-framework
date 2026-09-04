ephemeral "vault_kv_secret_v2" "terraform_secrets" {
  mount = "admin-kv"
  name  = "engine-terraform"
}

resource "vault_terraform_cloud_secret_backend" "terraform" {
  backend = "terraform"

  token_wo         = tostring(ephemeral.vault_kv_secret_v2.terraform_secrets.data["token_wo"])
  token_wo_version = var.vault_terraform_token_wo_version
}
