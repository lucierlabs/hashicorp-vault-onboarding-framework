locals {
  input_csv  = file("${path.module}/${var.input_file}")
  input_data = csvdecode(local.input_csv)

  input_list = [
    for row in local.input_data : {
      app     = row.application
      sub     = row.sub-application
      env     = row.environment
      perms   = row.permissions
      cluster = row.cluster
      ns      = row.namespace
    }
  ]

  ns_list = [
    for row in local.input_list : row.ns
  ]

  output_list = [
    for row in local.input_list : {
      app           = row.app
      sub           = row.sub
      env           = row.env
      perms         = row.perms
      cluster       = row.cluster
      ns            = row.ns
      map_key       = "${vault_jwt_auth_backend.jwt_kubernetes.path}-${row.ns}"
      alias         = row.ns
      auth_path     = vault_jwt_auth_backend.jwt_kubernetes.path
      auth_accessor = vault_jwt_auth_backend.jwt_kubernetes.accessor
    }
  ]
}
