ephemeral "vault_kv_secret_v2" "terraform_secrets" {
  for_each = var.racf_domains

  mount = "admin-kv"
  name  = "auth-ldap-racf/${each.key}"
}

resource "vault_ldap_auth_backend" "ldap_racf" {
  for_each = var.racf_domains

  path = "ldap-racf-${each.key}"
  url  = each.value.ldap_racf_url

  binddn              = each.value.ldap_racf_bind_dn
  bindpass_wo         = tostring(ephemeral.vault_kv_secret_v2.terraform_secrets[each.key].data["bindpass_wo"])
  bindpass_wo_version = each.value.ldap_racf_bindpass_wo_version

  userdn            = each.value.ldap_racf_user_dn
  userattr          = each.value.ldap_racf_user_attribute
  userfilter        = each.value.ldap_racf_user_filter
  groupdn           = each.value.ldap_racf_group_dn
  groupfilter       = each.value.ldap_racf_group_filter
  groupattr         = each.value.ldap_racf_group_attribute
  deny_null_bind    = true
  username_as_alias = true

  token_policies = []
  token_ttl      = var.token_ttl
}
