ephemeral "vault_kv_secret_v2" "terraform_secrets" {
  mount = "admin-kv"
  name  = "auth-ldap-racf/${var.racf_domain}"
}

resource "vault_ldap_auth_backend" "ldap_racf" {
  path = "ldap-racf"
  url  = var.racf_ldap_url

  binddn              = var.racf_ldap_bind_dn
  bindpass_wo         = tostring(ephemeral.vault_kv_secret_v2.terraform_secrets.data["bindpass_wo"])
  bindpass_wo_version = var.racf_ldap_bindpass_wo_version

  userdn            = var.racf_ldap_user_dn
  userattr          = var.racf_user_attribute
  userfilter        = var.racf_user_filter
  groupdn           = var.racf_ldap_group_dn
  groupfilter       = var.racf_group_filter
  groupattr         = var.racf_group_attribute
  deny_null_bind    = true
  username_as_alias = true

  token_policies = []
  token_ttl      = var.token_ttl
}
