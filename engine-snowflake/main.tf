resource "vault_mount" "engine_snowflake" {
  path = "snowflake"
  type = "database"
}

ephemeral "vault_kv_secret_v2" "terraform_secrets" {
  for_each = local.active_connections

  mount = "admin-kv"
  name  = "engine-snowflake/${each.key}"
}

resource "vault_database_secret_backend_connection" "snowflake" {
  for_each = local.active_connections

  backend       = vault_mount.engine_snowflake.path
  name          = each.key
  plugin_name   = "snowflake-database-plugin"
  allowed_roles = local.connection_roles[each.key]

  snowflake {
    connection_url         = each.value.connection_url
    username               = each.value.username
    private_key_wo         = tostring(ephemeral.vault_kv_secret_v2.terraform_secrets[each.key].data["private_key_wo"])
    private_key_wo_version = each.value.private_key_wo_version
  }
}

resource "vault_database_secret_backend_static_role" "snowflake_app_roles" {
  for_each = { for row in local.input_list : row.app_role => row if row.sub == "" }

  backend             = vault_mount.engine_snowflake.path
  name                = each.value.app_role
  db_name             = vault_database_secret_backend_connection.snowflake[each.value.connection].name
  username            = each.value.acct
  rotation_period     = each.value.ttl
  rotation_statements = ["ALTER USER {{name}} SET RSA_PUBLIC_KEY='{{public_key}}'"]
  credential_type     = "rsa_private_key"
  credential_config = {
    key_bits = "2048"
  }
}

resource "vault_database_secret_backend_static_role" "snowflake_sub_roles" {
  for_each = { for row in local.input_list : row.sub_role => row if row.sub != "" }

  backend             = vault_mount.engine_snowflake.path
  name                = each.value.sub_role
  db_name             = vault_database_secret_backend_connection.snowflake[each.value.connection].name
  username            = each.value.acct
  rotation_period     = each.value.ttl
  rotation_statements = ["ALTER USER {{name}} SET RSA_PUBLIC_KEY='{{public_key}}'"]
  credential_type     = "rsa_private_key"
  credential_config = {
    key_bits = "2048"
  }
}
