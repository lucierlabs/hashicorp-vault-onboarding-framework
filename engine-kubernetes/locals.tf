locals {
  input_csv  = file("${path.module}/${var.engine_kubernetes_input_file}")
  input_data = csvdecode(local.input_csv)

  input_list = [
    for row in local.input_data : {
      app_key      = "${row.cluster}-${row.application}-${row.environment}-${row.namespace}-${row.service-account}"
      app_role     = "${row.application}-${row.environment}-${row.namespace}-${row.service-account}"
      sub_key      = "${row.cluster}-${row.application}-${row.sub-application}-${row.environment}-${row.namespace}-${row.service-account}"
      sub_role     = "${row.application}-${row.sub-application}-${row.environment}-${row.namespace}-${row.service-account}"
      app          = row.application
      sub          = row.sub-application
      env          = row.environment
      cluster      = row.cluster
      ns           = row.namespace
      service_acct = row.service-account
      ttl          = tonumber(row.ttl)
    } if contains(var.environments, row.environment)
  ]
}
