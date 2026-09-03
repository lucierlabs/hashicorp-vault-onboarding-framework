resource "vault_jwt_auth_backend" "jwt_terraform" {
  path               = "jwt-terraform"
  description        = "Terraform JWT Auth Method"
  oidc_discovery_url = "https://app.terraform.io"
  bound_issuer       = "https://app.terraform.io"
}

resource "vault_jwt_auth_backend_role" "app_default_role" {
  count = length(local.input_list) > 0 ? 1 : 0

  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "app-default-role"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = join(",", local.work_sub_list)
  }

  token_policies = []
  token_ttl      = var.token_ttl
}
