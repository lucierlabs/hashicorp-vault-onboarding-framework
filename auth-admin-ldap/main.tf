ephemeral "vault_kv_secret_v2" "terraform_secrets" {
  mount = "admin-kv"
  name  = "auth-admin-ldap/${var.admin_ldap_domain}"
}

resource "vault_ldap_auth_backend" "admin_ldap" {
  path = "admin-ldap"
  url  = var.admin_ldap_url

  binddn              = var.admin_ldap_bind_dn
  bindpass_wo         = tostring(ephemeral.vault_kv_secret_v2.terraform_secrets.data["bindpass_wo"])
  bindpass_wo_version = var.admin_ldap_bindpass_wo_version

  userdn            = var.admin_ldap_user_dn
  userattr          = "sAMAccountName"
  userfilter        = "(sAMAccountName={{.Username}})"
  groupdn           = var.admin_ldap_group_search_dn
  groupfilter       = "(&(objectClass=group)(|(sAMAccountName=${var.admin_read_only_group_sam_account_name})(sAMAccountName=${var.admin_read_write_group_sam_account_name}))(member={{.UserDN}}))"
  groupattr         = "sAMAccountName"
  upndomain         = var.admin_ldap_upn_domain
  deny_null_bind    = true
  username_as_alias = true

  token_policies = []
  token_ttl      = var.token_ttl
}

resource "vault_policy" "auth_admin_ldap_admin_read_only" {
  name   = "auth-admin-ldap-admin-read-only"
  policy = <<EOT
path "*" {
  capabilities = ["read", "list"]
}
EOT
}

resource "vault_policy" "auth_admin_ldap_admin_read_write" {
  name   = "auth-admin-ldap-admin-read-write"
  policy = <<EOT
path "*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
EOT
}

resource "vault_ldap_auth_backend_group" "admin_read_only" {
  backend   = vault_ldap_auth_backend.admin_ldap.path
  groupname = var.admin_read_only_group_sam_account_name
  policies  = [vault_policy.auth_admin_ldap_admin_read_only.name]
}

resource "vault_ldap_auth_backend_group" "admin_read_write" {
  backend   = vault_ldap_auth_backend.admin_ldap.path
  groupname = var.admin_read_write_group_sam_account_name
  policies  = [vault_policy.auth_admin_ldap_admin_read_write.name]
}
