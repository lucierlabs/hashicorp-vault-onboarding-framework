locals {
  input_csv  = file("${path.module}/${var.input_file}")
  input_data = csvdecode(local.input_csv)

  input_list = [
    for row in local.input_data : {
      app     = row.application
      sub     = row.sub-application
      env     = row.environment
      perms   = row.permissions
      subject = row.subject
      issuer  = row.issuer
    }
  ]

  subject_list = [
    for row in local.input_list : row.subject
  ]

  output_list = [
    for row in local.input_list : {
      app           = row.app
      sub           = row.sub
      env           = row.env
      perms         = row.perms
      subject       = row.subject
      issuer        = row.issuer
      map_key       = "${vault_auth_backend.tls_certificates.path}-${row.subject}"
      alias         = row.subject
      auth_path     = vault_auth_backend.tls_certificates.path
      auth_accessor = vault_auth_backend.tls_certificates.accessor
    }
  ]
}
