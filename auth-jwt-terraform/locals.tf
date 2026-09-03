locals {
  input_csv  = file("${path.module}/${var.input_file}")
  input_data = csvdecode(local.input_csv)

  input_list = [
    for row in local.input_data : {
      app      = row.application
      sub      = row.sub-application
      env      = row.environment
      perms    = row.permissions
      org      = row.organization
      proj     = row.project
      work     = row.workspace
      work_sub = "organization:${row.organization}:project:${row.project}:workspace:${row.workspace}"
    }
  ]

  work_sub_list = [
    for row in local.input_list : row.work_sub
  ]

  output_list = [
    for row in local.input_list : {
      app           = row.app
      sub           = row.sub
      env           = row.env
      perms         = row.perms
      org           = row.org
      proj          = row.proj
      work          = row.work
      work_sub      = row.work_sub
      map_key       = "${vault_jwt_auth_backend.jwt_terraform.path}-${row.work_sub}"
      alias         = row.work_sub
      auth_path     = vault_jwt_auth_backend.jwt_terraform.path
      auth_accessor = vault_jwt_auth_backend.jwt_terraform.accessor
    }
  ]

}
