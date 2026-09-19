locals {
  input_csv  = file("${path.module}/${var.engine_terraform_input_file}")
  input_data = csvdecode(local.input_csv)

  input_list = [
    for row in local.input_data : {
      app_role  = "${row.application}-${row.environment}-${row.organization}-${row.team-name}"
      sub_role  = "${row.application}-${row.sub-application}-${row.environment}-${row.organization}-${row.team-name}"
      app       = row.application
      sub       = row.sub-application
      env       = row.environment
      org       = row.organization
      team_name = row.team-name
      team_id   = row.team-id
      ttl       = tonumber(row.ttl)
    } if contains(var.environments, row.environment)
  ]
}
