resource "vault_jwt_auth_backend" "jwt_github" {
  path               = "jwt-github"
  description        = "GitHub JWT Auth Method"
  oidc_discovery_url = "https://token.actions.githubusercontent.com"
  bound_issuer       = "https://token.actions.githubusercontent.com"
}

resource "vault_jwt_auth_backend_role" "app_default_role" {
  count = length(local.input_list) > 0 ? 1 : 0

  backend   = vault_jwt_auth_backend.jwt_github.path
  role_name = "app-default-role"
  role_type = "jwt"

  user_claim = "sub"

  bound_audiences = local.repo_aud_list
  bound_claims = {
    sub = join(",", local.repo_sub_list)
  }

  token_policies = []
  token_ttl      = var.token_ttl
}
