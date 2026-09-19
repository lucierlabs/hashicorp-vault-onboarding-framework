ephemeral "vault_kv_secret_v2" "terraform_secrets" {
  for_each = var.active_directory_domains

  mount = "admin-kv"
  name  = "engine-ad/${each.key}"
}

resource "vault_ldap_secret_backend" "ad" {
  for_each = var.active_directory_domains

  path   = "ad-${each.key}"
  schema = "ad"

  url    = each.value.ldap_ad_url
  binddn = each.value.engine_ad_bind_dn
  userdn = each.value.engine_ad_user_dn

  bindpass_wo         = tostring(ephemeral.vault_kv_secret_v2.terraform_secrets[each.key].data["bindpass_wo"])
  bindpass_wo_version = each.value.engine_ad_bindpass_wo_version
}

resource "vault_ldap_secret_backend_static_role" "ad_app_roles" {
  for_each = { for row in local.input_list : row.app_key => row if row.sub == "" }

  mount     = vault_ldap_secret_backend.ad[each.value.domain].path
  role_name = each.value.app_role

  username        = each.value.acct
  rotation_period = each.value.ttl
}

resource "vault_ldap_secret_backend_static_role" "ad_sub_roles" {
  for_each = { for row in local.input_list : row.sub_key => row if row.sub != "" }

  mount     = vault_ldap_secret_backend.ad[each.value.domain].path
  role_name = each.value.sub_role

  username        = each.value.acct
  rotation_period = each.value.ttl
}
