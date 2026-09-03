resource "vault_jwt_auth_backend" "jwt_azure" {
  path               = "jwt-azure"
  description        = "Microsoft Entra ID JWT Auth Method"
  oidc_discovery_url = "https://login.microsoftonline.com/${var.azure_tenant_id}/v2.0"
  bound_issuer       = "https://login.microsoftonline.com/${var.azure_tenant_id}/v2.0"
}

resource "vault_jwt_auth_backend_role" "app_default_role" {
  count = length(local.input_list) > 0 ? 1 : 0

  backend   = vault_jwt_auth_backend.jwt_azure.path
  role_name = "app-default-role"
  role_type = "jwt"

  # Replace with "appid" if the application issues v1 access tokens.
  user_claim = "azp"

  bound_audiences = [var.azure_audience]
  bound_claims = {
    azp = join(",", local.client_id_list)
    tid = join(",", local.org_id_list)
  }

  token_policies = []
  token_ttl      = var.token_ttl
}
