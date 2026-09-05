resource "tfe_workspace" "this" {
  for_each = local.workspaces

  name              = each.value.name
  organization      = local.organization_name
  project_id        = data.tfe_project.this.id
  description       = "Manages ${each.value.component} for the ${each.value.environment} Vault environment."
  working_directory = each.value.component
  auto_apply        = false
  queue_all_runs    = false

  tags = {
    environment = each.value.environment
    component   = each.value.component
    system      = "vault-onboarding"
  }

  trigger_patterns = local.workspace_trigger_patterns[each.key]

  vcs_repo {
    identifier                 = local.vcs_repository
    branch                     = local.vcs_branch
    github_app_installation_id = data.tfe_github_app_installation.this.id
  }
}

resource "tfe_variable" "environment" {
  for_each = local.workspace_environment_variables

  workspace_id = tfe_workspace.this[each.value.workspace_name].id
  category     = "env"
  key          = each.value.key
  value        = each.value.value
  description  = each.value.description
  sensitive    = false
}

check "admin_roles_organization" {
  assert {
    condition = alltrue([
      for row in local.admin_roles : row.organization == local.organization_name
    ])
    error_message = "Every admin-roles.csv row must use organization '${local.organization_name}'."
  }
}

check "admin_roles_project" {
  assert {
    condition = alltrue([
      for row in local.admin_roles : row.project == local.project_name
    ])
    error_message = "Every admin-roles.csv row must use project '${local.project_name}'."
  }
}

check "admin_roles_workspace_names" {
  assert {
    condition = alltrue([
      for row in local.admin_roles : endswith(row.workspace, "-${row.environment}")
    ])
    error_message = "Every workspace in admin-roles.csv must end with its environment name."
  }
}

check "admin_roles_workspace_names_are_unique" {
  assert {
    condition = length(local.admin_roles) == length(toset([
      for row in local.admin_roles : row.workspace
    ]))
    error_message = "Workspace names in admin-roles.csv must be unique."
  }
}

check "vault_addresses_cover_csv_environments" {
  assert {
    condition = (
      length(setsubtract(toset(local.environments), toset(keys(local.vault_addrs)))) == 0 &&
      length(setsubtract(toset(keys(local.vault_addrs)), toset(local.environments))) == 0
    )
    error_message = "vault_addrs must have exactly one entry for every unique environment in admin-roles.csv."
  }
}
