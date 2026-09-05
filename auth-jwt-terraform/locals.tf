locals {
  input_csv  = file("${path.module}/${var.auth_jwt_terraform_input_file}")
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
    } if contains(var.environments, row.environment)
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

  admin_input_csv  = file("${path.module}/${var.auth_jwt_terraform_admin_input_file}")
  admin_input_data = csvdecode(local.admin_input_csv)

  admin_input_list = [
    for row in local.admin_input_data : {
      env      = row.environment
      work     = row.workspace
      policy   = [row.policy]
      work_sub = "organization:${row.organization}:project:${row.project}:workspace:${row.workspace}"
    } if contains(var.environments, row.environment)
  ]

  admin_work_sub_list = [
    for row in local.admin_input_list : row.work_sub
  ]

  admin_output_list = [
    for row in local.admin_input_list : {
      env           = row.env
      work          = row.work
      policy        = row.policy
      work_sub      = row.work_sub
      map_key       = "${vault_jwt_auth_backend.jwt_terraform.path}-${row.work_sub}"
      entity_name   = "admin-${row.work_sub}-entity"
      alias         = row.work_sub
      auth_path     = vault_jwt_auth_backend.jwt_terraform.path
      auth_accessor = vault_jwt_auth_backend.jwt_terraform.accessor
    }
  ]
}
