ephemeral "vault_kv_secret_v2" "terraform_secrets" {
  mount = "admin-kv"
  name  = "engine-azure"
}

resource "vault_azure_secret_backend" "azure" {
  path            = "azure"
  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id

  client_id                = var.engine_azure_client_id
  client_secret_wo         = tostring(ephemeral.vault_kv_secret_v2.terraform_secrets.data["client_secret_wo"])
  client_secret_wo_version = var.engine_azure_client_secret_wo_version
}

resource "vault_azure_secret_backend_role" "azure_app_roles" {
  for_each = { for row in local.input_list : row.app_role => row if row.sub == "" }

  backend               = vault_azure_secret_backend.azure.path
  role                  = each.value.app_role
  application_object_id = each.value.object_id
  ttl                   = each.value.ttl
  max_ttl               = each.value.ttl
}

resource "vault_azure_secret_backend_role" "azure_sub_roles" {
  for_each = { for row in local.input_list : row.sub_role => row if row.sub != "" }

  backend               = vault_azure_secret_backend.azure.path
  role                  = each.value.sub_role
  application_object_id = each.value.object_id
  ttl                   = each.value.ttl
  max_ttl               = each.value.ttl
}
