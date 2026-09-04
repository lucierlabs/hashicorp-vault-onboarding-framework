locals {
  approle_vault_aliases    = data.tfe_outputs.auth_approle_vault.nonsensitive_values.aliases
  jwt_azure_aliases        = data.tfe_outputs.auth_jwt_azure.nonsensitive_values.aliases
  jwt_github_aliases       = data.tfe_outputs.auth_jwt_github.nonsensitive_values.aliases
  jwt_harness_aliases      = data.tfe_outputs.auth_jwt_harness.nonsensitive_values.aliases
  jwt_kubernetes_aliases   = data.tfe_outputs.auth_jwt_kubernetes.nonsensitive_values.aliases
  jwt_terraform_aliases    = data.tfe_outputs.auth_jwt_terraform.nonsensitive_values.aliases
  kerberos_ad_aliases      = data.tfe_outputs.auth_kerberos_ad.nonsensitive_values.aliases
  ldap_ad_aliases          = data.tfe_outputs.auth_ldap_ad.nonsensitive_values.aliases
  ldap_racf_aliases        = data.tfe_outputs.auth_ldap_racf.nonsensitive_values.aliases
  msi_azure_aliases        = data.tfe_outputs.auth_msi_azure.nonsensitive_values.aliases
  sts_aws_aliases          = data.tfe_outputs.auth_sts_aws.nonsensitive_values.aliases
  tls_certificates_aliases = data.tfe_outputs.auth_tls_certificates.nonsensitive_values.aliases

  auth_method_aliases = merge(
    local.approle_vault_aliases,
    local.jwt_azure_aliases,
    local.jwt_github_aliases,
    local.jwt_harness_aliases,
    local.jwt_kubernetes_aliases,
    local.jwt_terraform_aliases,
    local.kerberos_ad_aliases,
    local.ldap_ad_aliases,
    local.ldap_racf_aliases,
    local.msi_azure_aliases,
    local.sts_aws_aliases,
    local.tls_certificates_aliases
  )

  read_aliases = {
    for key, row in local.auth_method_aliases :
    key => {
      app           = row.app
      sub           = row.sub
      env           = row.env
      perms         = row.perms
      alias         = row.alias
      auth_path     = row.auth_path
      auth_accessor = row.auth_accessor
      entity_name   = "${row.app}-${row.sub}-${row.env}-${row.perms}-${row.auth_path}-${row.alias}-entity"
      policy        = [vault_policy.workload_read_policy.name]
    } if row.perms == "read"
  }

  write_aliases = {
    for key, row in local.auth_method_aliases :
    key => {
      app           = row.app
      sub           = row.sub
      env           = row.env
      perms         = row.perms
      alias         = row.alias
      auth_path     = row.auth_path
      auth_accessor = row.auth_accessor
      entity_name   = "${row.app}-${row.sub}-${row.env}-${row.perms}-${row.auth_path}-${row.alias}-entity"
      policy        = [vault_policy.workload_write_policy.name]
    } if row.perms == "write"
  }

  readwrite_aliases = {
    for key, row in local.auth_method_aliases :
    key => {
      app           = row.app
      sub           = row.sub
      env           = row.env
      perms         = row.perms
      alias         = row.alias
      auth_path     = row.auth_path
      auth_accessor = row.auth_accessor
      entity_name   = "${row.app}-${row.sub}-${row.env}-${row.perms}-${row.auth_path}-${row.alias}-entity"
      policy        = [vault_policy.workload_read_policy.name, vault_policy.workload_write_policy.name]
    } if row.perms == "readwrite"
  }

  all_aliases = merge(
    local.read_aliases,
    local.write_aliases,
    local.readwrite_aliases
  )
}
