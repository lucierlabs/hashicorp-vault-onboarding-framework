ephemeral "vault_kv_secret_v2" "terraform_secrets" {
  mount = "admin-kv"
  name  = "engine-azure"
}

resource "vault_azure_secret_backend" "azure" {
  path            = "azure"
  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id

  client_id                = var.vault_azure_client_id
  client_secret_wo         = tostring(ephemeral.vault_kv_secret_v2.terraform_secrets.data["client_secret_wo"])
  client_secret_wo_version = var.vault_azure_client_secret_wo_version
}
