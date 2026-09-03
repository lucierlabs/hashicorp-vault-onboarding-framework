resource "vault_jwt_auth_backend" "jwt_kubernetes" {
  path               = "jwt-kubernetes-lab"
  description        = "Kubernetes JWT Auth Method"
  oidc_discovery_url = var.kubernetes_oidc_issuer
  bound_issuer       = var.kubernetes_oidc_issuer
}

resource "vault_jwt_auth_backend_role" "app_default_role" {
  count = length(local.input_list) > 0 ? 1 : 0

  backend   = vault_jwt_auth_backend.jwt_kubernetes.path
  role_name = "app-default-role"
  role_type = "jwt"

  user_claim              = "/kubernetes.io/namespace"
  user_claim_json_pointer = true

  bound_audiences = [var.kubernetes_audience]
  bound_claims = {
    "/kubernetes.io/namespace" = join(",", local.ns_list)
  }

  token_policies = []
  token_ttl      = var.token_ttl
}
