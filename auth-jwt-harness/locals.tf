locals {
  input_csv  = file("${path.module}/${var.auth_jwt_harness_input_file}")
  input_data = csvdecode(local.input_csv)

  input_list = [
    for row in local.input_data : {
      app     = row.application
      sub     = row.sub-application
      env     = row.environment
      perms   = row.permissions
      proj_id = row.project-id
      conn_id = row.connector-id
    } if contains(var.environments, row.environment)
  ]

  proj_id_list = [
    for row in local.input_list : row.proj_id
  ]

  conn_id_list = [
    for row in local.input_list : row.conn_id
  ]

  output_list = [
    for row in local.input_list : {
      app           = row.app
      sub           = row.sub
      env           = row.env
      perms         = row.perms
      proj_id       = row.proj_id
      conn_id       = row.conn_id
      map_key       = "${vault_jwt_auth_backend.jwt_harness.path}-${row.conn_id}"
      alias         = row.conn_id
      auth_path     = vault_jwt_auth_backend.jwt_harness.path
      auth_accessor = vault_jwt_auth_backend.jwt_harness.accessor
    }
  ]
}
