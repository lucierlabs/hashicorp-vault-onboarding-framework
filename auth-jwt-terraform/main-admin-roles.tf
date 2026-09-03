resource "vault_jwt_auth_backend_role" "admin_auth_admin_ldap" {
  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "admin-auth-admin-ldap"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = "organization:lucierlabs:project:hashicorp-vault-onboarding:workspace:auth-admin-ldap"
  }

  token_policies = [vault_policy.admin_auth_admin_ldap_policy.name]
  token_ttl      = var.token_ttl
}

resource "vault_policy" "admin_auth_admin_ldap_policy" {
  name   = "admin-auth-admin-ldap-policy"
  policy = <<EOT
path "sys/auth/admin-ldap" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/auth/admin-ldap" {
  capabilities = ["read"]
}

path "sys/mounts/auth/admin-ldap/tune" {
  capabilities = ["read", "update"]
}

path "auth/admin-ldap/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "admin-kv/data/auth-admin-ldap/*" {
  capabilities = ["read"]
}

path "sys/policies/acl/auth-admin-ldap-*" {
  capabilities = ["create", "read", "update", "delete"]
}
EOT
}

resource "vault_jwt_auth_backend_role" "admin_auth_approle_vault" {
  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "admin-auth-approle-vault"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = "organization:lucierlabs:project:hashicorp-vault-onboarding:workspace:auth-approle-vault"
  }

  token_policies = [vault_policy.admin_auth_approle_vault_policy.name]
  token_ttl      = var.token_ttl
}

resource "vault_policy" "admin_auth_approle_vault_policy" {
  name   = "admin-auth-approle-vault-policy"
  policy = <<EOT
path "sys/auth/approle-vault" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/auth/approle-vault" {
  capabilities = ["read"]
}

path "sys/mounts/auth/approle-vault/tune" {
  capabilities = ["read", "update"]
}

path "auth/approle-vault/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOT
}

resource "vault_jwt_auth_backend_role" "admin_auth_jwt_azure" {
  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "admin-auth-jwt-azure"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = "organization:lucierlabs:project:hashicorp-vault-onboarding:workspace:auth-jwt-azure"
  }

  token_policies = [vault_policy.admin_auth_jwt_azure_policy.name]
  token_ttl      = var.token_ttl
}

resource "vault_policy" "admin_auth_jwt_azure_policy" {
  name   = "admin-auth-jwt-azure-policy"
  policy = <<EOT
path "sys/auth/jwt-azure" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/auth/jwt-azure" {
  capabilities = ["read"]
}

path "sys/mounts/auth/jwt-azure/tune" {
  capabilities = ["read", "update"]
}

path "auth/jwt-azure/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOT
}

resource "vault_jwt_auth_backend_role" "admin_auth_jwt_github" {
  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "admin-auth-jwt-github"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = "organization:lucierlabs:project:hashicorp-vault-onboarding:workspace:auth-jwt-github"
  }

  token_policies = [vault_policy.admin_auth_jwt_github_policy.name]
  token_ttl      = var.token_ttl
}

resource "vault_policy" "admin_auth_jwt_github_policy" {
  name   = "admin-auth-jwt-github-policy"
  policy = <<EOT
path "sys/auth/jwt-github" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/auth/jwt-github" {
  capabilities = ["read"]
}

path "sys/mounts/auth/jwt-github/tune" {
  capabilities = ["read", "update"]
}

path "auth/jwt-github/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOT
}

resource "vault_jwt_auth_backend_role" "admin_auth_jwt_harness" {
  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "admin-auth-jwt-harness"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = "organization:lucierlabs:project:hashicorp-vault-onboarding:workspace:auth-jwt-harness"
  }

  token_policies = [vault_policy.admin_auth_jwt_harness_policy.name]
  token_ttl      = var.token_ttl
}

resource "vault_policy" "admin_auth_jwt_harness_policy" {
  name   = "admin-auth-jwt-harness-policy"
  policy = <<EOT
path "sys/auth/jwt-harness" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/auth/jwt-harness" {
  capabilities = ["read"]
}

path "sys/mounts/auth/jwt-harness/tune" {
  capabilities = ["read", "update"]
}

path "auth/jwt-harness/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOT
}

resource "vault_jwt_auth_backend_role" "admin_auth_jwt_kubernetes" {
  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "admin-auth-jwt-kubernetes"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = "organization:lucierlabs:project:hashicorp-vault-onboarding:workspace:auth-jwt-kubernetes"
  }

  token_policies = [vault_policy.admin_auth_jwt_kubernetes_policy.name]
  token_ttl      = var.token_ttl
}

resource "vault_policy" "admin_auth_jwt_kubernetes_policy" {
  name   = "admin-auth-jwt-kubernetes-policy"
  policy = <<EOT
path "sys/auth/jwt-kubernetes-lab" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/auth/jwt-kubernetes-lab" {
  capabilities = ["read"]
}

path "sys/mounts/auth/jwt-kubernetes-lab/tune" {
  capabilities = ["read", "update"]
}

path "auth/jwt-kubernetes-lab/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOT
}

resource "vault_jwt_auth_backend_role" "admin_auth_jwt_terraform" {
  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "admin-auth-jwt-terraform"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = "organization:lucierlabs:project:hashicorp-vault-onboarding:workspace:auth-jwt-terraform"
  }

  token_policies = [vault_policy.admin_auth_jwt_terraform_policy.name]
  token_ttl      = var.token_ttl
}

resource "vault_policy" "admin_auth_jwt_terraform_policy" {
  name   = "admin-auth-jwt-terraform-policy"
  policy = <<EOT
path "sys/auth/jwt-terraform" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/auth/jwt-terraform" {
  capabilities = ["read"]
}

path "sys/mounts/auth/jwt-terraform/tune" {
  capabilities = ["read", "update"]
}

path "auth/jwt-terraform/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "sys/policies/acl/admin-auth-*" {
  capabilities = ["create", "read", "update", "delete"]
}
EOT
}

resource "vault_jwt_auth_backend_role" "admin_auth_kerberos_ad" {
  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "admin-auth-kerberos-ad"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = "organization:lucierlabs:project:hashicorp-vault-onboarding:workspace:auth-kerberos-ad"
  }

  token_policies = [vault_policy.admin_auth_kerberos_ad_policy.name]
  token_ttl      = var.token_ttl
}

resource "vault_policy" "admin_auth_kerberos_ad_policy" {
  name   = "admin-auth-kerberos-ad-policy"
  policy = <<EOT
path "sys/auth/kerberos-ad-corp" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/auth/kerberos-ad-corp" {
  capabilities = ["read"]
}

path "sys/mounts/auth/kerberos-ad-corp/tune" {
  capabilities = ["read", "update"]
}

path "auth/kerberos-ad-corp/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "admin-kv/data/auth-kerberos-ad/*" {
  capabilities = ["read"]
}
EOT
}

resource "vault_jwt_auth_backend_role" "admin_auth_ldap_ad" {
  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "admin-auth-ldap-ad"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = "organization:lucierlabs:project:hashicorp-vault-onboarding:workspace:auth-ldap-ad"
  }

  token_policies = [vault_policy.admin_auth_ldap_ad_policy.name]
  token_ttl      = var.token_ttl
}

resource "vault_policy" "admin_auth_ldap_ad_policy" {
  name   = "admin-auth-ldap-ad-policy"
  policy = <<EOT
path "sys/auth/ldap-ad-corp" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/auth/ldap-ad-corp" {
  capabilities = ["read"]
}

path "sys/mounts/auth/ldap-ad-corp/tune" {
  capabilities = ["read", "update"]
}

path "auth/ldap-ad-corp/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "admin-kv/data/auth-ldap-ad/*" {
  capabilities = ["read"]
}
EOT
}

resource "vault_jwt_auth_backend_role" "admin_auth_ldap_racf" {
  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "admin-auth-ldap-racf"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = "organization:lucierlabs:project:hashicorp-vault-onboarding:workspace:auth-ldap-racf"
  }

  token_policies = [vault_policy.admin_auth_ldap_racf_policy.name]
  token_ttl      = var.token_ttl
}

resource "vault_policy" "admin_auth_ldap_racf_policy" {
  name   = "admin-auth-ldap-racf-policy"
  policy = <<EOT
path "sys/auth/ldap-racf" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/auth/ldap-racf" {
  capabilities = ["read"]
}

path "sys/mounts/auth/ldap-racf/tune" {
  capabilities = ["read", "update"]
}

path "auth/ldap-racf/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "admin-kv/data/auth-ldap-racf/*" {
  capabilities = ["read"]
}
EOT
}

resource "vault_jwt_auth_backend_role" "admin_auth_msi_azure" {
  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "admin-auth-msi-azure"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = "organization:lucierlabs:project:hashicorp-vault-onboarding:workspace:auth-msi-azure"
  }

  token_policies = [vault_policy.admin_auth_msi_azure_policy.name]
  token_ttl      = var.token_ttl
}

resource "vault_policy" "admin_auth_msi_azure_policy" {
  name   = "admin-auth-msi-azure-policy"
  policy = <<EOT
path "sys/auth/msi-azure" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/auth/msi-azure" {
  capabilities = ["read"]
}

path "sys/mounts/auth/msi-azure/tune" {
  capabilities = ["read", "update"]
}

path "auth/msi-azure/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "admin-kv/data/auth-msi-azure/*" {
  capabilities = ["read"]
}
EOT
}

resource "vault_jwt_auth_backend_role" "admin_auth_oidc_okta" {
  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "admin-auth-oidc-okta"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = "organization:lucierlabs:project:hashicorp-vault-onboarding:workspace:auth-oidc-okta"
  }

  token_policies = [vault_policy.admin_auth_oidc_okta_policy.name]
  token_ttl      = var.token_ttl
}

resource "vault_policy" "admin_auth_oidc_okta_policy" {
  name   = "admin-auth-oidc-okta-policy"
  policy = <<EOT
path "sys/auth/oidc" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/auth/oidc" {
  capabilities = ["read"]
}

path "sys/mounts/auth/oidc/tune" {
  capabilities = ["read", "update"]
}

path "auth/oidc/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "admin-kv/data/auth-oidc-okta/*" {
  capabilities = ["read"]
}
EOT
}

resource "vault_jwt_auth_backend_role" "admin_auth_sts_aws" {
  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "admin-auth-sts-aws"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = "organization:lucierlabs:project:hashicorp-vault-onboarding:workspace:auth-sts-aws"
  }

  token_policies = [vault_policy.admin_auth_sts_aws_policy.name]
  token_ttl      = var.token_ttl
}

resource "vault_policy" "admin_auth_sts_aws_policy" {
  name   = "admin-auth-sts-aws-policy"
  policy = <<EOT
path "sys/auth/sts-aws" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/auth/sts-aws" {
  capabilities = ["read"]
}

path "sys/mounts/auth/sts-aws/tune" {
  capabilities = ["read", "update"]
}

path "auth/sts-aws/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "admin-kv/data/auth-sts-aws/*" {
  capabilities = ["read"]
}
EOT
}

resource "vault_jwt_auth_backend_role" "admin_auth_tls_certificates" {
  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "admin-auth-tls-certificates"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = "organization:lucierlabs:project:hashicorp-vault-onboarding:workspace:auth-tls-certificates"
  }

  token_policies = [vault_policy.admin_auth_tls_certificates_policy.name]
  token_ttl      = var.token_ttl
}

resource "vault_policy" "admin_auth_tls_certificates_policy" {
  name   = "admin-auth-tls-certificates-policy"
  policy = <<EOT
path "sys/auth/tls-certificates" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/auth/tls-certificates" {
  capabilities = ["read"]
}

path "sys/mounts/auth/tls-certificates/tune" {
  capabilities = ["read", "update"]
}

path "auth/tls-certificates/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOT
}
