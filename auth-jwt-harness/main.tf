resource "vault_jwt_auth_backend" "jwt_harness" {
  path               = "jwt-harness"
  description        = "Harness JWT Auth Method"
  oidc_discovery_url = var.harness_oidc_discovery_url
  bound_issuer       = var.harness_oidc_discovery_url
}

resource "vault_jwt_auth_backend_role" "app_default_role" {
  count = length(local.input_list) > 0 ? 1 : 0

  backend   = vault_jwt_auth_backend.jwt_harness.path
  role_name = "app-default-role"
  role_type = "jwt"

  user_claim = "connector_id"

  bound_audiences = [var.harness_audience]
  bound_claims = {
    project_id   = join(",", local.proj_id_list)
    connector_id = join(",", local.conn_id_list)
  }

  token_policies = []
  token_ttl      = var.token_ttl
}
