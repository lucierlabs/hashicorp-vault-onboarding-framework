locals {
  input_csv  = file("${path.module}/${var.input_file}")
  input_data = csvdecode(local.input_csv)

  input_list = [
    for row in local.input_data : {
      app       = row.application
      sub       = row.sub-application
      env       = row.environment
      perms     = row.permissions
      acct_name = row.account-name
      acct_id   = row.account-id
      iam_role  = row.iam-role
      role_arn  = "arn:aws:iam::${row.account-id}:role/${row.iam-role}"
    }
  ]

  role_arn_list = [
    for row in local.input_list : row.role_arn
  ]

  account_id_list = distinct([
    for row in local.input_list : row.acct_id
  ])

  output_list = [
    for row in local.input_list : {
      app           = row.app
      sub           = row.sub
      env           = row.env
      perms         = row.perms
      acct_name     = row.acct_name
      acct_id       = row.acct_id
      iam_role      = row.iam_role
      role_arn      = row.role_arn
      map_key       = "${vault_auth_backend.sts_aws.path}-${row.role_arn}"
      alias         = row.role_arn
      auth_path     = vault_auth_backend.sts_aws.path
      auth_accessor = vault_auth_backend.sts_aws.accessor
    }
  ]
}
