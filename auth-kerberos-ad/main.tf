ephemeral "vault_kv_secret_v2" "terraform_secrets" {
  mount = "admin-kv"
  name  = "auth-kerberos-ad/corp"
}

resource "vault_auth_backend" "kerberos_ad" {
  type = "kerberos"
  path = "kerberos-ad-corp"

  tune {
    passthrough_request_headers = ["Authorization"]
    allowed_response_headers    = ["www-authenticate"]
  }
}

resource "vault_kerberos_auth_backend_config" "kerberos_ad" {
  mount             = vault_auth_backend.kerberos_ad.path
  keytab_wo         = tostring(ephemeral.vault_kv_secret_v2.terraform_secrets.data["keytab_wo"])
  keytab_wo_version = var.kerberos_keytab_wo_version
  service_account   = var.kerberos_service_account
  add_group_aliases = true
}

resource "vault_kerberos_auth_backend_ldap_config" "kerberos_ad" {
  mount = vault_auth_backend.kerberos_ad.path
  url   = var.kerberos_ldap_url

  binddn              = var.kerberos_ldap_bind_dn
  bindpass_wo         = tostring(ephemeral.vault_kv_secret_v2.terraform_secrets.data["bindpass_wo"])
  bindpass_wo_version = var.kerberos_ldap_bindpass_wo_version

  userdn            = var.kerberos_ldap_user_dn
  userattr          = "sAMAccountName"
  userfilter        = "(sAMAccountName={{.Username}})"
  groupdn           = var.kerberos_ldap_group_dn
  groupfilter       = "(&(objectClass=group)(sAMAccountName=${var.kerberos_group_sam_account_name})(member={{.UserDN}}))"
  groupattr         = "sAMAccountName"
  upndomain         = var.kerberos_upn_domain
  deny_null_bind    = true
  username_as_alias = true

  token_policies = []
  token_ttl      = var.token_ttl
}
