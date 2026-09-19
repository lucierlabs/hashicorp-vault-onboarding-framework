locals {
  input_csv  = file("${path.module}/${var.engine_aws_input_file}")
  input_data = csvdecode(local.input_csv)

  input_list = [
    for row in local.input_data : {
      app_role  = "${row.application}-${row.environment}-${row.account-name}-${row.account-id}-${replace(row.iam-role, "/", "-")}"
      sub_role  = "${row.application}-${row.sub-application}-${row.environment}-${row.account-name}-${row.account-id}-${replace(row.iam-role, "/", "-")}"
      app       = row.application
      sub       = row.sub-application
      env       = row.environment
      acct_name = row.account-name
      acct_id   = row.account-id
      iam_role  = row.iam-role
      ttl       = tonumber(row.ttl)
    } if contains(var.environments, row.environment)
  ]
}
