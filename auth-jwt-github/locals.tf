locals {
  input_csv  = file("${path.module}/../${var.input_file}")
  input_data = csvdecode("${local.input_csv}")

  input_list = [
    for row in local.input_data : {
      app        = row.application
      sub        = row.sub-application
      env        = row.environment
      perms      = row.permissions
      repo       = row.repository
      repo_owner = row.repo-owner
      repo_env   = row.repo-environment
      repo_sub   = "repo:${row.repo-owner}/${row.repository}:environment:${row.repo-environment}"
    }
  ]

  repo_sub_list = [
    for row in local.input_list : row.repo_sub
  ]

  repo_aud_list = [
    for row in local.input_list : "https://github.com/${row.repo_owner}"
  ]

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
