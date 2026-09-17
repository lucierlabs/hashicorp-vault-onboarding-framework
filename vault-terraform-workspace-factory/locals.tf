locals {
  organization_name = "lucierlabs"
  project_name      = "hashicorp-vault-onboarding"

  vcs_repository               = "lucierlabs/hashicorp-vault-onboarding-framework"
  vcs_branch                   = "main"
  github_app_installation_name = "lucierlabs"
  admin_workspaces_csv_path    = "${path.module}/../input-files/admin-workspaces.csv"
  vault_wif_auth_path          = "jwt-terraform"
  vault_wif_audience           = "vault.workload.identity"
  default_vault_wif_role       = "admin-default-role"
  identity_vault_wif_role      = "admin-engine-identity"

  # These addresses are intentionally explicit because each CSV environment
  # represents a separate Vault deployment. Confirm test and prod before apply.
  vault_addrs = {
    dev  = "https://vault-dev.lucierlabs.com"
    test = "https://vault-test.lucierlabs.com"
    prod = "https://vault-prod.lucierlabs.com"
  }

  admin_workspaces = csvdecode(file(local.admin_workspaces_csv_path))
  environments = sort(distinct([
    for row in local.admin_workspaces : row.environment
  ]))

  csv_workspaces = {
    for row in local.admin_workspaces : row.workspace => {
      name              = row.workspace
      environment       = row.environment
      component         = trimsuffix(row.workspace, "-${row.environment}")
      vault_wif_enabled = true
      vault_wif_role    = local.default_vault_wif_role
      source            = "admin-workspaces.csv"
    }
    # Keep the two generated workspace families authoritative even if they are
    # accidentally added to the CSV later.
    if !contains([
      "auth-jwt-terraform-${row.environment}",
      "engine-identity-${row.environment}",
    ], row.workspace)
  }

  auth_jwt_terraform_workspaces = {
    for environment in local.environments : "auth-jwt-terraform-${environment}" => {
      name              = "auth-jwt-terraform-${environment}"
      environment       = environment
      component         = "auth-jwt-terraform"
      vault_wif_enabled = false
      vault_wif_role    = null
      source            = "generated"
    }
  }

  engine_identity_workspaces = {
    for environment in local.environments : "engine-identity-${environment}" => {
      name              = "engine-identity-${environment}"
      environment       = environment
      component         = "engine-identity"
      vault_wif_enabled = true
      vault_wif_role    = local.identity_vault_wif_role
      source            = "generated"
    }
  }

  workspaces = merge(
    local.csv_workspaces,
    local.auth_jwt_terraform_workspaces,
    local.engine_identity_workspaces,
  )

  workspace_trigger_patterns = {
    for workspace_name, workspace in local.workspaces : workspace_name => compact([
      "${workspace.component}/**",
      "tfvars-environment/${workspace.environment}.tfvars",
      fileexists("${path.module}/../input-files/${workspace.component}.csv") ? "input-files/${workspace.component}.csv" : null,
      contains(["auth-jwt-terraform", "engine-identity"], workspace.component) ? "input-files/admin-workspaces.csv" : null,
    ])
  }

  terraform_cli_environment_variables = merge([
    for workspace_name, workspace in local.workspaces : {
      "${workspace_name}:cli-args" = {
        workspace_name = workspace_name
        key            = "TF_CLI_ARGS"
        value          = "-var-file=../tfvars-environment/${workspace.environment}.tfvars"
        description    = "Selects the ${workspace.environment} environment configuration for all Terraform CLI commands."
      }
    }
  ]...)

  vault_wif_environment_variables = merge([
    for workspace_name, workspace in local.workspaces : {
      for key, value in {
        TFC_VAULT_PROVIDER_AUTH              = "true"
        TFC_VAULT_ADDR                       = local.vault_addrs[workspace.environment]
        TFC_VAULT_RUN_ROLE                   = workspace.vault_wif_role
        TFC_VAULT_AUTH_PATH                  = local.vault_wif_auth_path
        TFC_VAULT_WORKLOAD_IDENTITY_AUDIENCE = local.vault_wif_audience
        } : "${workspace_name}:${key}" => {
        workspace_name = workspace_name
        key            = key
        value          = value
        description    = "Vault workload identity configuration managed by the workspace factory."
      }
    } if workspace.vault_wif_enabled
  ]...)

  workspace_environment_variables = merge(
    local.terraform_cli_environment_variables,
    local.vault_wif_environment_variables,
  )
}
