# Auth methods

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

# Engines

resource "vault_jwt_auth_backend_role" "admin_engine_ad" {
  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "admin-engine-ad"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = "organization:lucierlabs:project:hashicorp-vault-onboarding:workspace:engine-ad"
  }

  token_policies = [vault_policy.admin_engine_ad_policy.name]
  token_ttl      = var.token_ttl
}

resource "vault_policy" "admin_engine_ad_policy" {
  name   = "admin-engine-ad-policy"
  policy = <<EOT
path "sys/mounts/ad-corp" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/ad-corp/tune" {
  capabilities = ["read", "update"]
}

path "ad-corp/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "ad-corp/creds/*" {
  capabilities = ["deny"]
}

path "ad-corp/library/+/check-out" {
  capabilities = ["deny"]
}

path "ad-corp/rotate-role/*" {
  capabilities = ["deny"]
}

path "ad-corp/static-cred/*" {
  capabilities = ["deny"]
}

path "admin-kv/data/engine-ad" {
  capabilities = ["read"]
}

path "admin-kv/data/engine-ad/*" {
  capabilities = ["read"]
}
EOT
}

resource "vault_jwt_auth_backend_role" "admin_engine_aws" {
  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "admin-engine-aws"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = "organization:lucierlabs:project:hashicorp-vault-onboarding:workspace:engine-aws"
  }

  token_policies = [vault_policy.admin_engine_aws_policy.name]
  token_ttl      = var.token_ttl
}

resource "vault_policy" "admin_engine_aws_policy" {
  name   = "admin-engine-aws-policy"
  policy = <<EOT
path "sys/mounts/aws" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/aws/tune" {
  capabilities = ["read", "update"]
}

path "aws/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "aws/creds/*" {
  capabilities = ["deny"]
}

path "aws/static-creds/*" {
  capabilities = ["deny"]
}

path "aws/sts/*" {
  capabilities = ["deny"]
}

path "admin-kv/data/engine-aws" {
  capabilities = ["read"]
}

path "admin-kv/data/engine-aws/*" {
  capabilities = ["read"]
}
EOT
}

resource "vault_jwt_auth_backend_role" "admin_engine_azure" {
  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "admin-engine-azure"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = "organization:lucierlabs:project:hashicorp-vault-onboarding:workspace:engine-azure"
  }

  token_policies = [vault_policy.admin_engine_azure_policy.name]
  token_ttl      = var.token_ttl
}

resource "vault_policy" "admin_engine_azure_policy" {
  name   = "admin-engine-azure-policy"
  policy = <<EOT
path "sys/mounts/azure" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/azure/tune" {
  capabilities = ["read", "update"]
}

path "azure/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "azure/creds/*" {
  capabilities = ["deny"]
}

path "azure/rotate-role/*" {
  capabilities = ["deny"]
}

path "azure/static-creds/*" {
  capabilities = ["deny"]
}

path "admin-kv/data/engine-azure" {
  capabilities = ["read"]
}

path "admin-kv/data/engine-azure/*" {
  capabilities = ["read"]
}
EOT
}

resource "vault_jwt_auth_backend_role" "admin_engine_identity" {
  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "admin-engine-identity"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = "organization:lucierlabs:project:hashicorp-vault-onboarding:workspace:engine-identity"
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
EOT
}

resource "vault_jwt_auth_backend_role" "admin_engine_kubernetes" {
  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "admin-engine-kubernetes"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = "organization:lucierlabs:project:hashicorp-vault-onboarding:workspace:engine-kubernetes"
  }

  token_policies = [vault_policy.admin_engine_kubernetes_policy.name]
  token_ttl      = var.token_ttl
}

resource "vault_policy" "admin_engine_kubernetes_policy" {
  name   = "admin-engine-kubernetes-policy"
  policy = <<EOT
path "sys/mounts/kubernetes-lab" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/kubernetes-lab/tune" {
  capabilities = ["read", "update"]
}

path "kubernetes-lab/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "kubernetes-lab/creds/*" {
  capabilities = ["deny"]
}

path "admin-kv/data/engine-kubernetes" {
  capabilities = ["read"]
}

path "admin-kv/data/engine-kubernetes/*" {
  capabilities = ["read"]
}
EOT
}

resource "vault_jwt_auth_backend_role" "admin_engine_kv" {
  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "admin-engine-kv"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = "organization:lucierlabs:project:hashicorp-vault-onboarding:workspace:engine-kv"
  }

  token_policies = [vault_policy.admin_engine_kv_policy.name]
  token_ttl      = var.token_ttl
}

resource "vault_policy" "admin_engine_kv_policy" {
  name   = "admin-engine-kv-policy"
  policy = <<EOT
path "sys/mounts/kv" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/kv/tune" {
  capabilities = ["read", "update"]
}

path "kv/config" {
  capabilities = ["create", "read", "update", "delete"]
}

path "sys/mounts/admin-kv" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/admin-kv/tune" {
  capabilities = ["read", "update"]
}

path "admin-kv/config" {
  capabilities = ["create", "read", "update", "delete"]
}
EOT
}

resource "vault_jwt_auth_backend_role" "admin_engine_mysql" {
  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "admin-engine-mysql"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = "organization:lucierlabs:project:hashicorp-vault-onboarding:workspace:engine-mysql"
  }

  token_policies = [vault_policy.admin_engine_mysql_policy.name]
  token_ttl      = var.token_ttl
}

resource "vault_policy" "admin_engine_mysql_policy" {
  name   = "admin-engine-mysql-policy"
  policy = <<EOT
path "sys/mounts/mysql" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/mysql/tune" {
  capabilities = ["read", "update"]
}

path "mysql/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "mysql/creds/*" {
  capabilities = ["deny"]
}

path "mysql/rotate-role/*" {
  capabilities = ["deny"]
}

path "mysql/static-creds/*" {
  capabilities = ["deny"]
}

path "admin-kv/data/engine-mysql" {
  capabilities = ["read"]
}

path "admin-kv/data/engine-mysql/*" {
  capabilities = ["read"]
}
EOT
}

resource "vault_jwt_auth_backend_role" "admin_engine_oracle" {
  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "admin-engine-oracle"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = "organization:lucierlabs:project:hashicorp-vault-onboarding:workspace:engine-oracle"
  }

  token_policies = [vault_policy.admin_engine_oracle_policy.name]
  token_ttl      = var.token_ttl
}

resource "vault_policy" "admin_engine_oracle_policy" {
  name   = "admin-engine-oracle-policy"
  policy = <<EOT
path "sys/mounts/oracle" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/oracle/tune" {
  capabilities = ["read", "update"]
}

path "oracle/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "oracle/creds/*" {
  capabilities = ["deny"]
}

path "oracle/rotate-role/*" {
  capabilities = ["deny"]
}

path "oracle/static-creds/*" {
  capabilities = ["deny"]
}

path "admin-kv/data/engine-oracle" {
  capabilities = ["read"]
}

path "admin-kv/data/engine-oracle/*" {
  capabilities = ["read"]
}
EOT
}

resource "vault_jwt_auth_backend_role" "admin_engine_postgres" {
  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "admin-engine-postgres"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = "organization:lucierlabs:project:hashicorp-vault-onboarding:workspace:engine-postgres"
  }

  token_policies = [vault_policy.admin_engine_postgres_policy.name]
  token_ttl      = var.token_ttl
}

resource "vault_policy" "admin_engine_postgres_policy" {
  name   = "admin-engine-postgres-policy"
  policy = <<EOT
path "sys/mounts/postgres" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/postgres/tune" {
  capabilities = ["read", "update"]
}

path "postgres/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "postgres/creds/*" {
  capabilities = ["deny"]
}

path "postgres/rotate-role/*" {
  capabilities = ["deny"]
}

path "postgres/static-creds/*" {
  capabilities = ["deny"]
}

path "admin-kv/data/engine-postgres" {
  capabilities = ["read"]
}

path "admin-kv/data/engine-postgres/*" {
  capabilities = ["read"]
}
EOT
}

resource "vault_jwt_auth_backend_role" "admin_engine_snowflake" {
  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "admin-engine-snowflake"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = "organization:lucierlabs:project:hashicorp-vault-onboarding:workspace:engine-snowflake"
  }

  token_policies = [vault_policy.admin_engine_snowflake_policy.name]
  token_ttl      = var.token_ttl
}

resource "vault_policy" "admin_engine_snowflake_policy" {
  name   = "admin-engine-snowflake-policy"
  policy = <<EOT
path "sys/mounts/snowflake" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/snowflake/tune" {
  capabilities = ["read", "update"]
}

path "snowflake/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "snowflake/creds/*" {
  capabilities = ["deny"]
}

path "snowflake/rotate-role/*" {
  capabilities = ["deny"]
}

path "snowflake/static-creds/*" {
  capabilities = ["deny"]
}

path "admin-kv/data/engine-snowflake" {
  capabilities = ["read"]
}

path "admin-kv/data/engine-snowflake/*" {
  capabilities = ["read"]
}
EOT
}

resource "vault_jwt_auth_backend_role" "admin_engine_terraform" {
  backend   = vault_jwt_auth_backend.jwt_terraform.path
  role_name = "admin-engine-terraform"
  role_type = "jwt"

  user_claim = "terraform_full_workspace"

  bound_audiences = ["vault.workload.identity"]
  bound_claims = {
    terraform_full_workspace = "organization:lucierlabs:project:hashicorp-vault-onboarding:workspace:engine-terraform"
  }

  token_policies = [vault_policy.admin_engine_terraform_policy.name]
  token_ttl      = var.token_ttl
}

resource "vault_policy" "admin_engine_terraform_policy" {
  name   = "admin-engine-terraform-policy"
  policy = <<EOT
path "sys/mounts/terraform" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/terraform/tune" {
  capabilities = ["read", "update"]
}

path "terraform/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "terraform/creds/*" {
  capabilities = ["deny"]
}

path "terraform/rotate-role/*" {
  capabilities = ["deny"]
}

path "admin-kv/data/engine-terraform" {
  capabilities = ["read"]
}

path "admin-kv/data/engine-terraform/*" {
  capabilities = ["read"]
}
EOT
}
