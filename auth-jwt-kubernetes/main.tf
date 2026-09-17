resource "vault_jwt_auth_backend" "jwt_kubernetes" {
  for_each = var.kubernetes_clusters

  path               = "jwt-kubernetes-${each.key}"
  description        = "Kubernetes JWT Auth Method"
  oidc_discovery_url = each.value.kubernetes_oidc_issuer
  bound_issuer       = each.value.kubernetes_oidc_issuer
}

resource "vault_jwt_auth_backend_role" "app_default_role" {
  for_each = var.kubernetes_clusters

  backend   = vault_jwt_auth_backend.jwt_kubernetes[each.key].path
  role_name = "app-default-role"
  role_type = "jwt"

  user_claim              = "/kubernetes.io/namespace"
  user_claim_json_pointer = true

  bound_audiences = [each.value.kubernetes_audience]
  bound_claims = {
    "/kubernetes.io/namespace" = join(",", local.ns_list[each.key])
  }

  token_policies = []
  token_ttl      = var.token_ttl
}
