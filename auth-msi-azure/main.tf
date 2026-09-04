ephemeral "vault_kv_secret_v2" "terraform_secrets" {
  mount = "admin-kv"
  name  = "auth-msi-azure"
}

resource "vault_auth_backend" "msi_azure" {
  type = "azure"
  path = "msi-azure"
}

resource "vault_azure_auth_backend_config" "msi_azure" {
  backend   = vault_auth_backend.msi_azure.path
  tenant_id = var.azure_tenant_id
  resource  = var.azure_resource_uri

  client_id                = var.vault_azure_client_id
  client_secret_wo         = tostring(ephemeral.vault_kv_secret_v2.terraform_secrets.data["client_secret_wo"])
  client_secret_wo_version = var.vault_azure_client_secret_wo_version
}

resource "vault_azure_auth_backend_role" "app_default_role" {
  backend = vault_auth_backend.msi_azure.path
  role    = "app-default-role"

  bound_service_principal_ids = local.object_id_list

  token_policies = []
  token_ttl      = var.token_ttl
}
