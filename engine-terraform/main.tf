ephemeral "vault_kv_secret_v2" "terraform_secrets" {
  mount = "admin-kv"
  name  = "engine-terraform"
}

resource "vault_terraform_cloud_secret_backend" "terraform" {
  backend = "terraform"

  token_wo         = tostring(ephemeral.vault_kv_secret_v2.terraform_secrets.data["token_wo"])
  token_wo_version = var.vault_terraform_token_wo_version
}

resource "vault_terraform_cloud_secret_role" "terraform_app_roles" {
  for_each = { for row in local.input_list : row.app_role => row if row.sub == "" }

  backend         = vault_terraform_cloud_secret_backend.terraform.backend
  name            = each.value.app_role
  credential_type = "team"
  organization    = each.value.org
  team_id         = each.value.team_id
  ttl             = each.value.ttl
  max_ttl         = each.value.ttl
}

resource "vault_terraform_cloud_secret_role" "terraform_sub_roles" {
  for_each = { for row in local.input_list : row.sub_role => row if row.sub != "" }

  backend         = vault_terraform_cloud_secret_backend.terraform.backend
  name            = each.value.sub_role
  credential_type = "team"
  organization    = each.value.org
  team_id         = each.value.team_id
  ttl             = each.value.ttl
  max_ttl         = each.value.ttl
}
