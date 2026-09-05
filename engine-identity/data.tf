data "tfe_outputs" "auth_approle_vault" {
  organization = "lucierlabs"
  workspace    = "auth-approle-vault-${var.hcp_terraform_workspace_environment}"
}

data "tfe_outputs" "auth_jwt_azure" {
  organization = "lucierlabs"
  workspace    = "auth-jwt-azure-${var.hcp_terraform_workspace_environment}"
}

data "tfe_outputs" "auth_jwt_github" {
  organization = "lucierlabs"
  workspace    = "auth-jwt-github-${var.hcp_terraform_workspace_environment}"
}

data "tfe_outputs" "auth_jwt_harness" {
  organization = "lucierlabs"
  workspace    = "auth-jwt-harness-${var.hcp_terraform_workspace_environment}"
}

data "tfe_outputs" "auth_jwt_kubernetes" {
  organization = "lucierlabs"
  workspace    = "auth-jwt-kubernetes-${var.hcp_terraform_workspace_environment}"
}

data "tfe_outputs" "auth_jwt_terraform" {
  organization = "lucierlabs"
  workspace    = "auth-jwt-terraform-${var.hcp_terraform_workspace_environment}"
}

data "tfe_outputs" "auth_kerberos_ad" {
  organization = "lucierlabs"
  workspace    = "auth-kerberos-ad-${var.hcp_terraform_workspace_environment}"
}

data "tfe_outputs" "auth_ldap_ad" {
  organization = "lucierlabs"
  workspace    = "auth-ldap-ad-${var.hcp_terraform_workspace_environment}"
}

data "tfe_outputs" "auth_ldap_racf" {
  organization = "lucierlabs"
  workspace    = "auth-ldap-racf-${var.hcp_terraform_workspace_environment}"
}

data "tfe_outputs" "auth_msi_azure" {
  organization = "lucierlabs"
  workspace    = "auth-msi-azure-${var.hcp_terraform_workspace_environment}"
}

data "tfe_outputs" "auth_sts_aws" {
  organization = "lucierlabs"
  workspace    = "auth-sts-aws-${var.hcp_terraform_workspace_environment}"
}

data "tfe_outputs" "auth_tls_certificates" {
  organization = "lucierlabs"
  workspace    = "auth-tls-certificates-${var.hcp_terraform_workspace_environment}"
}
