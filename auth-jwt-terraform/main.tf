resource "vault_jwt_auth_backend" "jwt_terraform" {
  path               = "jwt-terraform"
  description        = "Terraform JWT Auth Method"
  oidc_discovery_url = "https://app.terraform.io"
  bound_issuer       = "https://app.terraform.io"
}

resource "vault_jwt_auth_backend_role" "app_default_role" {
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

resource "vault_jwt_auth_backend_role" "admin_default_role" {
  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "admin-default-role"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = join(",", local.admin_work_sub_list)
  }

  token_policies = []
  token_ttl      = var.token_ttl
}

resource "vault_jwt_auth_backend_role" "admin_engine_identity" {
  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "admin-engine-identity"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = var.engine_identity_terraform_full_workspace
  }

  token_policies = [vault_policy.admin_engine_identity_policy.name]
  token_ttl      = var.token_ttl
}

resource "vault_policy" "admin_engine_identity_policy" {
  name   = "admin-engine-identity-policy"
  policy = <<EOT
path "identity/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "identity/oidc/token/*" {
  capabilities = ["deny"]
}

path "sys/policies/acl/workload-*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "sys/policies/acl/admin-*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOT
}
