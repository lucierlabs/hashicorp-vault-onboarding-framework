resource "vault_auth_backend" "approle_vault" {
  type = "approle"
  path = "approle-vault"
}

resource "vault_approle_auth_backend_role" "app_role" {
  for_each = {
    for row in local.input_list : row.role_id => row
  }

  backend   = vault_auth_backend.approle_vault.path
  role_name = each.value.role_id
  role_id   = each.value.role_id

  token_policies = []
  token_ttl      = var.token_ttl
}
