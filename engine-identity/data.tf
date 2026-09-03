data "tfe_outputs" "auth_admin_ldap" {
  organization = "lucierlabs"
  workspace    = "auth-admin-ldap"
}

data "tfe_outputs" "auth_approle_vault" {
  organization = "lucierlabs"
  workspace    = "auth-approle-vault"
}

data "tfe_outputs" "auth_jwt_azure" {
  organization = "lucierlabs"
  workspace    = "auth-jwt-azure"
}

data "tfe_outputs" "auth_jwt_github" {
  organization = "lucierlabs"
  workspace    = "auth-jwt-github"
}

data "tfe_outputs" "auth_jwt_harness" {
  organization = "lucierlabs"
  workspace    = "auth-jwt-harness"
}

data "tfe_outputs" "auth_jwt_kubernetes" {
  organization = "lucierlabs"
  workspace    = "auth-jwt-kubernetes"
}

data "tfe_outputs" "auth_jwt_terraform" {
  organization = "lucierlabs"
  workspace    = "auth-jwt-terraform"
}

data "tfe_outputs" "auth_kerberos_ad" {
  organization = "lucierlabs"
  workspace    = "auth-kerberos-ad"
}

data "tfe_outputs" "auth_ldap_ad" {
  organization = "lucierlabs"
  workspace    = "auth-ldap-ad"
}

data "tfe_outputs" "auth_ldap_racf" {
  organization = "lucierlabs"
  workspace    = "auth-ldap-racf"
}

data "tfe_outputs" "auth_msi_azure" {
  organization = "lucierlabs"
  workspace    = "auth-msi-azure"
}

data "tfe_outputs" "auth_oidc_okta" {
  organization = "lucierlabs"
  workspace    = "auth-oidc-okta"
}

data "tfe_outputs" "auth_sts_aws" {
  organization = "lucierlabs"
  workspace    = "auth-sts-aws"
}

data "tfe_outputs" "auth_tls_certificates" {
  organization = "lucierlabs"
  workspace    = "auth-tls-certificates"
}
