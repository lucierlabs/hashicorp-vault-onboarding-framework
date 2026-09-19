ephemeral "vault_kv_secret_v2" "terraform_secrets" {
  for_each = var.racf_domains

  mount = "admin-kv"
  name  = "engine-racf/${each.key}"
}

resource "vault_ldap_secret_backend" "racf" {
  for_each = var.racf_domains

  path            = "racf-${each.key}"
  schema          = "racf"
  credential_type = "phrase"
  password_policy = each.value.engine_racf_password_policy

  url      = each.value.ldap_racf_url
  binddn   = each.value.engine_racf_bind_dn
  userdn   = each.value.engine_racf_user_dn
  userattr = each.value.engine_racf_user_attribute

  bindpass_wo         = tostring(ephemeral.vault_kv_secret_v2.terraform_secrets[each.key].data["bindpass_wo"])
  bindpass_wo_version = each.value.engine_racf_bindpass_wo_version
}

resource "vault_ldap_secret_backend_static_role" "racf_app_roles" {
  for_each = { for row in local.input_list : row.app_key => row if row.sub == "" }

  mount     = vault_ldap_secret_backend.racf[each.value.domain].path
  role_name = each.value.app_role

  username        = each.value.acct
  rotation_period = each.value.ttl
}

resource "vault_ldap_secret_backend_static_role" "racf_sub_roles" {
  for_each = { for row in local.input_list : row.sub_key => row if row.sub != "" }

  mount     = vault_ldap_secret_backend.racf[each.value.domain].path
  role_name = each.value.sub_role

  username        = each.value.acct
  rotation_period = each.value.ttl
}
