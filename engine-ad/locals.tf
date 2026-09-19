locals {
  input_csv  = file("${path.module}/${var.engine_ad_input_file}")
  input_data = csvdecode(local.input_csv)

  input_list = [
    for row in local.input_data : {
      app_key  = "${row.application}-${row.environment}-${row.domain}-${row.account}"
      app_role = "${row.application}-${row.environment}-${row.account}"
      sub_key  = "${row.application}-${row.sub-application}-${row.environment}-${row.domain}-${row.account}"
      sub_role = "${row.application}-${row.sub-application}-${row.environment}-${row.account}"
      app      = row.application
      sub      = row.sub-application
      env      = row.environment
      domain   = row.domain
      acct     = row.account
      ttl      = tonumber(row.ttl)
    } if contains(var.environments, row.environment)
  ]
}
