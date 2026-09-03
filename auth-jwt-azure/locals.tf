locals {
  input_csv  = file("${path.module}/${var.input_file}")
  input_data = csvdecode(local.input_csv)

  input_list = [
    for row in local.input_data : {
      app       = row.application
      sub       = row.sub-application
      env       = row.environment
      perms     = row.permissions
      reg_name  = row.application-registration-name
      client_id = row.application-registration-client-id
      org_id    = row.application-registration-organization-id
    }
  ]

  client_id_list = [
    for row in local.input_list : row.client_id
  ]

  org_id_list = [
    for row in local.input_list : row.org_id
  ]

  output_list = [
    for row in local.input_list : {
      app           = row.app
      sub           = row.sub
      env           = row.env
      perms         = row.perms
      reg_name      = row.reg_name
      client_id     = row.client_id
      org_id        = row.org_id
      map_key       = "${vault_jwt_auth_backend.jwt_azure.path}-${row.client_id}"
      alias         = row.client_id
      auth_path     = vault_jwt_auth_backend.jwt_azure.path
      auth_accessor = vault_jwt_auth_backend.jwt_azure.accessor
    }
  ]
}
