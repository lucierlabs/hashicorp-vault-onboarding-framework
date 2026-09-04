ephemeral "vault_kv_secret_v2" "terraform_secrets" {
  mount = "admin-kv"
  name  = "engine-ad"
}

resource "vault_ldap_secret_backend" "ad_corp" {
  path   = "ad-corp"
  schema = "ad"

  url    = var.ldap_ad_url
  binddn = var.ldap_ad_bind_dn
  userdn = var.ldap_ad_user_dn

  bindpass_wo         = tostring(ephemeral.vault_kv_secret_v2.terraform_secrets.data["bindpass_wo"])
  bindpass_wo_version = var.ldap_ad_bindpass_wo_version
}
