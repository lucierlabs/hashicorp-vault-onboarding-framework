ephemeral "vault_kv_secret_v2" "terraform_secrets" {
  for_each = var.active_directory_domains

  mount = "admin-kv"
  name  = "auth-kerberos-ad/${each.key}"
}

resource "vault_auth_backend" "kerberos_ad" {
  for_each = var.active_directory_domains

  type = "kerberos"
  path = "kerberos-ad-${each.key}"

  tune {
    passthrough_request_headers = ["Authorization"]
    allowed_response_headers    = ["www-authenticate"]
  }
}

resource "vault_kerberos_auth_backend_config" "kerberos_ad" {
  for_each = var.active_directory_domains

  mount             = vault_auth_backend.kerberos_ad[each.key].path
  keytab_wo         = tostring(ephemeral.vault_kv_secret_v2.terraform_secrets[each.key].data["keytab_wo"])
  keytab_wo_version = each.value.kerberos_keytab_wo_version
  service_account   = each.value.kerberos_service_account
  add_group_aliases = true
}

resource "vault_kerberos_auth_backend_ldap_config" "kerberos_ad" {
  for_each = var.active_directory_domains

  mount = vault_auth_backend.kerberos_ad[each.key].path
  url   = each.value.kerberos_ldap_url

  binddn              = each.value.kerberos_ldap_bind_dn
  bindpass_wo         = tostring(ephemeral.vault_kv_secret_v2.terraform_secrets[each.key].data["bindpass_wo"])
  bindpass_wo_version = each.value.kerberos_ldap_bindpass_wo_version

  userdn            = each.value.kerberos_ldap_user_dn
  userattr          = "sAMAccountName"
  userfilter        = "(sAMAccountName={{.Username}})"
  groupdn           = each.value.kerberos_ldap_group_dn
  groupfilter       = "(&(objectClass=group)(sAMAccountName=${each.value.kerberos_group_sam_account_name})(member={{.UserDN}}))"
  groupattr         = "sAMAccountName"
  upndomain         = each.value.kerberos_upn_domain
  deny_null_bind    = true
  username_as_alias = true

  token_policies = []
  token_ttl      = var.token_ttl
}
