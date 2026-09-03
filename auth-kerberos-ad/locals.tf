locals {
  input_csv  = file("${path.module}/${var.input_file}")
  input_data = csvdecode(local.input_csv)

  input_list = [
    for row in local.input_data : {
      app    = row.application
      sub    = row.sub-application
      env    = row.environment
      perms  = row.permissions
      domain = row.domain
      acct   = row.account
    }
  ]

  output_list = [
    for row in local.input_list : {
      app           = row.app
      sub           = row.sub
      env           = row.env
      perms         = row.perms
      domain        = row.domain
      acct          = row.acct
      map_key       = "${vault_auth_backend.kerberos_ad.path}-${row.acct}"
      alias         = row.acct
      auth_path     = vault_auth_backend.kerberos_ad.path
      auth_accessor = vault_auth_backend.kerberos_ad.accessor
    }
  ]
}
