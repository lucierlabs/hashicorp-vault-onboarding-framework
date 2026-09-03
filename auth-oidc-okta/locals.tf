locals {
  input_csv  = file("${path.module}/${var.input_file}")
  input_data = csvdecode(local.input_csv)

  input_list = [
    for row in local.input_data : {
      app   = row.application
      sub   = row.sub-application
      env   = row.environment
      perms = row.permissions
      group = row.group
    }
  ]

  group_list = [
    for row in local.input_list : row.group
  ]

  output_list = [
    for row in local.input_list : {
      app           = row.app
      sub           = row.sub
      env           = row.env
      perms         = row.perms
      group         = row.group
      map_key       = "${vault_jwt_auth_backend.oidc_okta.path}-${row.group}"
      alias         = row.group
      auth_path     = vault_jwt_auth_backend.oidc_okta.path
      auth_accessor = vault_jwt_auth_backend.oidc_okta.accessor
    }
  ]
}
