locals {
  input_csv = file("${path.module}/${var.input_file}")
  input_data = csvdecode(
    trimspace(local.input_csv) == "" ?
    "application,sub-application,environment,permissions,domain,account\n" :
    local.input_csv
  )

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
      map_key       = "${vault_ldap_auth_backend.ldap_racf.path}-${row.acct}"
      alias         = row.acct
      auth_path     = vault_ldap_auth_backend.ldap_racf.path
      auth_accessor = vault_ldap_auth_backend.ldap_racf.accessor
    }
  ]
}
