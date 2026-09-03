locals {
  input_csv  = file("${path.module}/${var.input_file}")
  input_data = csvdecode(local.input_csv)

  input_list = [
    for row in local.input_data : {
      app       = row.application
      sub       = row.sub-application
      env       = row.environment
      perms     = row.permissions
      msi_name  = row.managed-identity-name
      client_id = row.managed-identity-client-id
      object_id = row.managed-identity-object-id
    }
  ]

  object_id_list = [
    for row in local.input_list : row.object_id
  ]

  output_list = [
    for row in local.input_list : {
      app           = row.app
      sub           = row.sub
      env           = row.env
      perms         = row.perms
      msi_name      = row.msi_name
      client_id     = row.client_id
      object_id     = row.object_id
      map_key       = "${vault_auth_backend.msi_azure.path}-${row.object_id}"
      alias         = row.object_id
      auth_path     = vault_auth_backend.msi_azure.path
      auth_accessor = vault_auth_backend.msi_azure.accessor
    }
  ]
}
