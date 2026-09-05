data "tfe_project" "this" {
  organization = local.organization_name
  name         = local.project_name
}

data "tfe_github_app_installation" "this" {
  name = local.github_app_installation_name
}
