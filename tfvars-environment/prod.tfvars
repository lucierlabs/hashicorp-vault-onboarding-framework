# Common settings
environments                             = ["prod", "prod2", "dr"]
token_ttl                                = 14400
vault_addr                               = "TODO"
hcp_terraform_workspace_environment      = "prod"
engine_identity_terraform_full_workspace = "organization:lucierlabs:project:hashicorp-vault-onboarding:workspace:engine-identity-prod"
jwt_issuer                               = "https://wif-prod.lucierlabs.com/oidc"

# Shared platform endpoints
azure_tenant_id = "TODO"

# CSV inputs
auth_approle_vault_input_file       = "../input-files/auth-approle-vault.csv"
auth_jwt_azure_input_file           = "../input-files/auth-jwt-azure.csv"
auth_jwt_github_input_file          = "../input-files/auth-jwt-github.csv"
auth_jwt_harness_input_file         = "../input-files/auth-jwt-harness.csv"
auth_jwt_kubernetes_input_file      = "../input-files/auth-jwt-kubernetes.csv"
auth_jwt_terraform_input_file       = "../input-files/auth-jwt-terraform.csv"
auth_jwt_terraform_admin_input_file = "../input-files/admin-workspaces.csv"
auth_kerberos_ad_input_file         = "../input-files/auth-kerberos-ad.csv"
auth_ldap_ad_input_file             = "../input-files/auth-ldap-ad.csv"
auth_ldap_racf_input_file           = "../input-files/auth-ldap-racf.csv"
auth_msi_azure_input_file           = "../input-files/auth-msi-azure.csv"
auth_oidc_okta_input_file           = "../input-files/auth-oidc-okta.csv"
auth_sts_aws_input_file             = "../input-files/auth-sts-aws.csv"
auth_tls_certificates_input_file    = "../input-files/auth-tls-certificates.csv"
engine_ad_input_file                = "../input-files/engine-ad.csv"
engine_aws_input_file               = "../input-files/engine-aws.csv"
engine_azure_input_file             = "../input-files/engine-azure.csv"
engine_kubernetes_input_file        = "../input-files/engine-kubernetes.csv"
engine_mysql_input_file             = "../input-files/engine-mysql.csv"
engine_oracle_input_file            = "../input-files/engine-oracle.csv"
engine_postgres_input_file          = "../input-files/engine-postgres.csv"
engine_racf_input_file              = "../input-files/engine-racf.csv"
engine_snowflake_input_file         = "../input-files/engine-snowflake.csv"
engine_terraform_input_file         = "../input-files/engine-terraform.csv"

# Admin LDAP auth
admin_ldap_domain                       = "TODO"
admin_ldap_url                          = "TODO"
admin_ldap_bind_dn                      = "TODO"
admin_ldap_bindpass_wo_version          = 1
admin_ldap_user_dn                      = "TODO"
admin_read_only_group_sam_account_name  = "TODO"
admin_read_write_group_sam_account_name = "TODO"
admin_ldap_group_search_dn              = "TODO"
admin_ldap_upn_domain                   = "TODO"

# JWT auth
azure_audience             = "TODO"
harness_oidc_discovery_url = "TODO"
harness_audience           = "TODO"

# Kubernetes JWT auth clusters
kubernetes_clusters = {
  lab = {
    kubernetes_oidc_issuer         = "TODO"
    kubernetes_audience            = "TODO"
    kubernetes_host                = "TODO"
    kubernetes_ca_cert             = "TODO"
    service_account_jwt_wo_version = 1
  }
}

# Active Directory domains
active_directory_domains = {
  corp = {
    ldap_ad_url                       = "TODO"
    engine_ad_bind_dn                 = "TODO"
    engine_ad_bindpass_wo_version     = 1
    engine_ad_user_dn                 = "TODO"
    ldap_ad_bind_dn                   = "TODO"
    ldap_ad_bindpass_wo_version       = 1
    ldap_ad_user_dn                   = "TODO"
    ldap_ad_group_sam_account_name    = "TODO"
    ldap_ad_group_dn                  = "TODO"
    ldap_ad_upn_domain                = "TODO"
    kerberos_service_account          = "TODO"
    kerberos_keytab_wo_version        = 1
    kerberos_ldap_url                 = "TODO"
    kerberos_ldap_bind_dn             = "TODO"
    kerberos_ldap_bindpass_wo_version = 1
    kerberos_ldap_user_dn             = "TODO"
    kerberos_group_sam_account_name   = "TODO"
    kerberos_ldap_group_dn            = "TODO"
    kerberos_upn_domain               = "TODO"
  }
}

# RACF domains
racf_domains = {
  mainframe = {
    ldap_racf_url                   = "TODO"
    ldap_racf_bind_dn               = "TODO"
    ldap_racf_bindpass_wo_version   = 1
    ldap_racf_user_dn               = "TODO"
    ldap_racf_user_attribute        = "TODO"
    ldap_racf_user_filter           = "TODO"
    ldap_racf_group_dn              = "TODO"
    ldap_racf_group_filter          = "TODO"
    ldap_racf_group_attribute       = "TODO"
    engine_racf_bind_dn             = "TODO"
    engine_racf_bindpass_wo_version = 1
    engine_racf_user_dn             = "TODO"
    engine_racf_user_attribute      = "racfid"
    engine_racf_password_policy     = "TODO"
  }
}

# Azure MSI auth
azure_resource_uri                   = "TODO"
vault_azure_client_id                = "TODO"
vault_azure_client_secret_wo_version = 1

# Okta OIDC auth
okta_domain                        = "TODO"
okta_oidc_client_id                = "TODO"
okta_oidc_client_secret_wo_version = 1

# AWS STS auth
vault_aws_access_key_id         = "TODO"
vault_aws_secret_key_wo_version = 1
cross_account_sts_role_name     = "TODO"

# TLS certificate auth
trusted_ca_certificate_pem = "TODO"

# AWS secrets engine
engine_aws_access_key_id         = "TODO"
engine_aws_secret_key_wo_version = 1

# Azure secrets engine
azure_subscription_id                 = "TODO"
engine_azure_client_id                = "TODO"
engine_azure_client_secret_wo_version = 1

# Database secrets engine connections
engine_mysql_connections = {
  example = {
    connection_url      = "TODO"
    username            = "TODO"
    password_wo_version = 1
  }
}

engine_oracle_connections = {
  example = {
    connection_url      = "TODO"
    username            = "TODO"
    password_wo_version = 1
  }
}

engine_postgres_connections = {
  example = {
    connection_url      = "TODO"
    username            = "TODO"
    password_wo_version = 1
  }
}

engine_snowflake_connections = {
  example = {
    connection_url         = "TODO"
    username               = "TODO"
    private_key_wo_version = 1
  }
}

# HCP Terraform secrets engine
vault_terraform_token_wo_version = 1
