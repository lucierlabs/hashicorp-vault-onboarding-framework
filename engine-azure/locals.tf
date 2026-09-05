locals {
  input_csv  = file("${path.module}/${var.engine_azure_input_file}")
  input_data = csvdecode(local.input_csv)

  input_list = [
    for row in local.input_data : {
      app       = row.application
      sub       = row.sub-application
      env       = row.environment
      reg_name  = row.application-registration-name
      client_id = row.application-client-id
      object_id = row.application-object-id
    } if contains(var.environments, row.environment)
  ]
}
