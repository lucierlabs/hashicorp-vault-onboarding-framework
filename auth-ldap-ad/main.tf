ephemeral "vault_kv_secret_v2" "terraform_secrets" {
  mount = "admin-kv"
  name  = "auth-ldap-ad/corp"
}

resource "vault_ldap_auth_backend" "ldap_ad" {
  path = "ldap-ad-corp"
  url  = var.ldap_ad_url

  binddn              = var.ldap_ad_bind_dn
  bindpass_wo         = tostring(ephemeral.vault_kv_secret_v2.terraform_secrets.data["bindpass_wo"])
  bindpass_wo_version = var.ldap_ad_bindpass_wo_version

  userdn            = var.ldap_ad_user_dn
  userattr          = "sAMAccountName"
  userfilter        = "(sAMAccountName={{.Username}})"
  groupdn           = var.ldap_ad_group_dn
  groupfilter       = "(&(objectClass=group)(sAMAccountName=${var.ldap_ad_group_sam_account_name})(member={{.UserDN}}))"
  groupattr         = "sAMAccountName"
  upndomain         = var.ldap_ad_upn_domain
  deny_null_bind    = true
  username_as_alias = true

  token_policies = []
  token_ttl      = var.token_ttl
}
