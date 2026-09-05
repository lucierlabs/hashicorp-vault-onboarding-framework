locals {
  input_csv  = file("${path.module}/${var.engine_racf_input_file}")
  input_data = csvdecode(local.input_csv)

  input_list = [
    for row in local.input_data : {
      app    = row.application
      sub    = row.sub-application
      env    = row.environment
      domain = row.domain
      acct   = row.account
    } if contains(var.environments, row.environment)
  ]
}
