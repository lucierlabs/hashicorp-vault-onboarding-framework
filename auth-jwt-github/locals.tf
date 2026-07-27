locals {
  input_csv  = file("${path.module}/../${var.input_file}")
  input_data = csvdecode("${local.input_csv}")

  app_input_list = [
    for row in local.input_data : {
      app      = row.application
      env      = row.environment
      perms    = row.permissions
      repo     = row.permissions
      repo_env = row.repo-environment
    } if row.sub-application == ""
  ]

  sub_input_list = [
    for row in local.input_data : {
      app      = row.application
      sub      = row.sub-application
      env      = row.environment
      perms    = row.permissions
      repo     = row.repository
      repo_env = row.repo-environment
    } if row.sub-application != ""
  ]

  
}