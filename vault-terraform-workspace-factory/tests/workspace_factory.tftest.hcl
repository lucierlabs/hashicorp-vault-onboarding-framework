mock_provider "tfe" {}

run "workspace_inventory" {
  command = plan

  assert {
    condition = length(local.workspaces) == (
      length(local.csv_workspaces) + (2 * length(local.environments))
    )
    error_message = "The factory must add one auth-jwt-terraform and one engine-identity workspace per CSV environment."
  }

  assert {
    condition = alltrue([
      for environment in local.environments :
      contains(keys(local.workspaces), "auth-jwt-terraform-${environment}") &&
      contains(keys(local.workspaces), "engine-identity-${environment}")
    ])
    error_message = "Every CSV environment must have both generated bootstrap workspaces."
  }

  assert {
    condition = alltrue([
      for variable_key in keys(local.vault_wif_environment_variables) :
      !startswith(variable_key, "auth-jwt-terraform-")
    ])
    error_message = "auth-jwt-terraform workspaces must not receive Vault WIF variables."
  }

  assert {
    condition = alltrue([
      for environment in local.environments :
      local.vault_wif_environment_variables["engine-identity-${environment}:TFC_VAULT_RUN_ROLE"].value == local.identity_vault_wif_role
    ])
    error_message = "Every engine-identity workspace must use the dedicated Vault WIF role."
  }
}
