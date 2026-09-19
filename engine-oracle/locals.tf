locals {
  input_csv  = file("${path.module}/${var.engine_oracle_input_file}")
  input_data = csvdecode(local.input_csv)

  input_list = [
    for row in local.input_data : {
      app_role   = "${row.application}-${row.environment}-${row.connection}-${row.account}"
      sub_role   = "${row.application}-${row.sub-application}-${row.environment}-${row.connection}-${row.account}"
      app        = row.application
      sub        = row.sub-application
      env        = row.environment
      connection = row.connection
      acct       = row.account
      ttl        = tonumber(row.ttl)
    } if contains(var.environments, row.environment)
  ]

  connection_roles = {
    for connection in keys(var.engine_oracle_connections) : connection => [
      for row in local.input_list : row.sub == "" ? row.app_role : row.sub_role
      if row.connection == connection
    ]
  }

  active_connections = {
    for connection, config in var.engine_oracle_connections : connection => config
    if length(local.connection_roles[connection]) > 0
  }
}
