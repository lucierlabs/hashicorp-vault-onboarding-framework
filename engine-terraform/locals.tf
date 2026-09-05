locals {
  input_csv  = file("${path.module}/${var.engine_terraform_input_file}")
  input_data = csvdecode(local.input_csv)

  input_list = [
    for row in local.input_data : {
      app       = row.application
      sub       = row.sub-application
      env       = row.environment
      team_name = row.team-name
      team_id   = row.team-id
    } if contains(var.environments, row.environment)
  ]
}
