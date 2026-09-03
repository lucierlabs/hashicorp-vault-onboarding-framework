locals {
  input_csv  = file("${path.module}/${var.input_file}")
  input_data = csvdecode(local.input_csv)

  input_list = [
    for row in local.input_data : {
      app     = row.application
      sub     = row.sub-application
      env     = row.environment
      perms   = row.permissions
      role_id = "${row.application}-${row.sub-application}-${row.environment}"
    }
  ]

  output_list = [
    for row in local.input_list : {
      app           = row.app
      sub           = row.sub
      env           = row.env
      perms         = row.perms
      role_id       = row.role_id
      map_key       = "${vault_auth_backend.approle_vault.path}-${row.role_id}"
      alias         = row.role_id
      auth_path     = vault_auth_backend.approle_vault.path
      auth_accessor = vault_auth_backend.approle_vault.accessor
    }
  ]
}
