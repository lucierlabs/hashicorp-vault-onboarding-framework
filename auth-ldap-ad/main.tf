ephemeral "vault_kv_secret_v2" "terraform_secrets" {
  for_each = var.active_directory_domains

  mount = "admin-kv"
  name  = "auth-ldap-ad/${each.key}"
}

resource "vault_ldap_auth_backend" "ldap_ad" {
  for_each = var.active_directory_domains

  path = "ldap-ad-${each.key}"
  url  = each.value.ldap_ad_url

  binddn              = each.value.ldap_ad_bind_dn
  bindpass_wo         = tostring(ephemeral.vault_kv_secret_v2.terraform_secrets[each.key].data["bindpass_wo"])
  bindpass_wo_version = each.value.ldap_ad_bindpass_wo_version

  userdn            = each.value.ldap_ad_user_dn
  userattr          = "sAMAccountName"
  userfilter        = "(sAMAccountName={{.Username}})"
  groupdn           = each.value.ldap_ad_group_dn
  groupfilter       = "(&(objectClass=group)(sAMAccountName=${each.value.ldap_ad_group_sam_account_name})(member={{.UserDN}}))"
  groupattr         = "sAMAccountName"
  upndomain         = each.value.ldap_ad_upn_domain
  deny_null_bind    = true
  username_as_alias = true

  token_policies = []
  token_ttl      = var.token_ttl
}
