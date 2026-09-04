ephemeral "vault_kv_secret_v2" "terraform_secrets" {
  mount = "admin-kv"
  name  = "auth-oidc-okta"
}

resource "vault_jwt_auth_backend" "oidc_okta" {
  path         = "oidc"
  type         = "oidc"
  description  = "Okta OIDC Auth Method"
  default_role = "app-default-role"

  oidc_discovery_url            = "https://${var.okta_domain}/oauth2/default"
  bound_issuer                  = "https://${var.okta_domain}/oauth2/default"
  oidc_client_id                = var.okta_oidc_client_id
  oidc_client_secret_wo         = tostring(ephemeral.vault_kv_secret_v2.terraform_secrets.data["oidc_client_secret_wo"])
  oidc_client_secret_wo_version = var.okta_oidc_client_secret_wo_version
}

resource "vault_jwt_auth_backend_role" "app_default_role" {
  backend   = vault_jwt_auth_backend.oidc_okta.path
  role_name = "app-default-role"
  role_type = "oidc"

  user_claim   = "sub"
  groups_claim = "groups"
  oidc_scopes  = ["profile", "groups"]

  bound_audiences = [var.okta_oidc_client_id]
  bound_claims = {
    groups = join(",", local.group_list)
  }

  allowed_redirect_uris = [
    "http://localhost:8250/oidc/callback",
    "${var.vault_addr}/ui/vault/auth/oidc/oidc/callback",
  ]

  token_policies = []
  token_ttl      = var.token_ttl
}
