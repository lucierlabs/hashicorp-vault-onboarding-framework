locals {
  input_csv  = file("${path.module}/${var.auth_jwt_github_input_file}")
  input_data = csvdecode(local.input_csv)

  input_list = [
    for row in local.input_data : {
      app        = row.application
      sub        = row.sub-application
      env        = row.environment
      perms      = row.permissions
      repo       = row.repository
      repo_owner = row.owner
      repo_env   = row.repo-environment
      repo_sub   = "repo:${row.owner}/${row.repository}:environment:${row.repo-environment}"
    } if contains(var.environments, row.environment)
  ]

  repo_sub_list = [
    for row in local.input_list : row.repo_sub
  ]

  repo_aud_list = [
    for row in local.input_list : "https://github.com/${row.repo_owner}"
  ]

  output_list = [
    for row in local.input_list : {
      app           = row.app
      sub           = row.sub
      env           = row.env
      perms         = row.perms
      repo          = row.repo
      repo_owner    = row.repo_owner
      repo_env      = row.repo_env
      repo_sub      = row.repo_sub
      map_key       = "${vault_jwt_auth_backend.jwt_github.path}-${row.repo_sub}"
      alias         = row.repo_sub
      auth_path     = vault_jwt_auth_backend.jwt_github.path
      auth_accessor = vault_jwt_auth_backend.jwt_github.accessor
    }
  ]

}
