resource "vault_identity_entity" "admin_entities" {
  for_each = local.admin_aliases

  name     = each.value.entity_name
  policies = each.value.policy

  depends_on = [
    vault_policy.admin_auth_admin_ldap_policy,
    vault_policy.admin_auth_approle_vault_policy,
    vault_policy.admin_auth_jwt_azure_policy,
    vault_policy.admin_auth_jwt_github_policy,
    vault_policy.admin_auth_jwt_harness_policy,
    vault_policy.admin_auth_jwt_kubernetes_policy,
    vault_policy.admin_auth_jwt_terraform_policy,
    vault_policy.admin_auth_kerberos_ad_policy,
    vault_policy.admin_auth_ldap_ad_policy,
    vault_policy.admin_auth_ldap_racf_policy,
    vault_policy.admin_auth_msi_azure_policy,
    vault_policy.admin_auth_oidc_okta_policy,
    vault_policy.admin_auth_sts_aws_policy,
    vault_policy.admin_auth_tls_certificates_policy,
    vault_policy.admin_engine_ad_policy,
    vault_policy.admin_engine_aws_policy,
    vault_policy.admin_engine_azure_policy,
    vault_policy.admin_engine_kubernetes_policy,
    vault_policy.admin_engine_kv_policy,
    vault_policy.admin_engine_mysql_policy,
    vault_policy.admin_engine_oracle_policy,
    vault_policy.admin_engine_postgres_policy,
    vault_policy.admin_engine_snowflake_policy,
    vault_policy.admin_engine_terraform_policy,
  ]

  metadata = {
    env           = each.value.env
    workspace     = each.value.work
    alias         = each.value.alias
    auth_path     = each.value.auth_path
    auth_accessor = each.value.auth_accessor
  }
}

resource "vault_identity_entity_alias" "admin_aliases" {
  for_each = local.admin_aliases

  name           = each.value.alias
  mount_accessor = each.value.auth_accessor
  canonical_id   = vault_identity_entity.admin_entities[each.key].id
}

#
# Auth methods
#

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

resource "vault_policy" "admin_auth_jwt_kubernetes_policy" {
  name = "admin-auth-jwt-kubernetes-policy"
  policy = join("\n\n", [
    for cluster in sort(keys(var.kubernetes_clusters)) : <<-EOT
path "sys/auth/jwt-kubernetes-${cluster}" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/auth/jwt-kubernetes-${cluster}" {
  capabilities = ["read"]
}

path "sys/mounts/auth/jwt-kubernetes-${cluster}/tune" {
  capabilities = ["read", "update"]
}

path "auth/jwt-kubernetes-${cluster}/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOT
  ])
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

resource "vault_policy" "admin_auth_kerberos_ad_policy" {
  name = "admin-auth-kerberos-ad-policy"
  policy = join("\n\n", concat(
    [
      for domain in sort(keys(var.active_directory_domains)) : <<-EOT
path "sys/auth/kerberos-ad-${domain}" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/auth/kerberos-ad-${domain}" {
  capabilities = ["read"]
}

path "sys/mounts/auth/kerberos-ad-${domain}/tune" {
  capabilities = ["read", "update"]
}

path "auth/kerberos-ad-${domain}/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOT
    ],
    [
      <<-EOT

path "admin-kv/data/auth-kerberos-ad/*" {
  capabilities = ["read"]
}
EOT
    ],
  ))
}

resource "vault_policy" "admin_auth_ldap_ad_policy" {
  name = "admin-auth-ldap-ad-policy"
  policy = join("\n\n", concat(
    [
      for domain in sort(keys(var.active_directory_domains)) : <<-EOT
path "sys/auth/ldap-ad-${domain}" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/auth/ldap-ad-${domain}" {
  capabilities = ["read"]
}

path "sys/mounts/auth/ldap-ad-${domain}/tune" {
  capabilities = ["read", "update"]
}

path "auth/ldap-ad-${domain}/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOT
    ],
    [
      <<-EOT

path "admin-kv/data/auth-ldap-ad/*" {
  capabilities = ["read"]
}
EOT
    ],
  ))
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

#
# Engines
#

resource "vault_policy" "admin_engine_ad_policy" {
  name = "admin-engine-ad-policy"
  policy = join("\n\n", concat(
    [
      for domain in sort(keys(var.active_directory_domains)) : <<-EOT
path "sys/mounts/ad-${domain}" {
  capabilities = ["create", "read", "update", "delete", "sudo"]
}

path "sys/mounts/ad-${domain}/tune" {
  capabilities = ["read", "update"]
}

path "ad-${domain}/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "ad-${domain}/creds/*" {
  capabilities = ["deny"]
}

path "ad-${domain}/library/+/check-out" {
  capabilities = ["deny"]
}

path "ad-${domain}/rotate-role/*" {
  capabilities = ["deny"]
}

path "ad-${domain}/static-cred/*" {
  capabilities = ["deny"]
}
EOT
    ],
    [
      <<-EOT

path "admin-kv/data/engine-ad" {
  capabilities = ["read"]
}

path "admin-kv/data/engine-ad/*" {
  capabilities = ["read"]
}
EOT
    ],
  ))
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
