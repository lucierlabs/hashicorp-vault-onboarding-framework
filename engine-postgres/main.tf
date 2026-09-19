resource "vault_mount" "engine_postgres" {
  path = "postgres"
  type = "database"
}

ephemeral "vault_kv_secret_v2" "terraform_secrets" {
  for_each = local.active_connections

  mount = "admin-kv"
  name  = "engine-postgres/${each.key}"
}

resource "vault_database_secret_backend_connection" "postgres" {
  for_each = local.active_connections

  backend       = vault_mount.engine_postgres.path
  name          = each.key
  plugin_name   = "postgresql-database-plugin"
  allowed_roles = local.connection_roles[each.key]

  postgresql {
    connection_url      = each.value.connection_url
    username            = each.value.username
    password_wo         = tostring(ephemeral.vault_kv_secret_v2.terraform_secrets[each.key].data["password_wo"])
    password_wo_version = each.value.password_wo_version
  }
}

resource "vault_database_secret_backend_static_role" "postgres_app_roles" {
  for_each = { for row in local.input_list : row.app_role => row if row.sub == "" }

  backend             = vault_mount.engine_postgres.path
  name                = each.value.app_role
  db_name             = vault_database_secret_backend_connection.postgres[each.value.connection].name
  username            = each.value.acct
  rotation_period     = each.value.ttl
  rotation_statements = ["ALTER ROLE \"{{username}}\" WITH PASSWORD '{{password}}';"]
}

resource "vault_database_secret_backend_static_role" "postgres_sub_roles" {
  for_each = { for row in local.input_list : row.sub_role => row if row.sub != "" }

  backend             = vault_mount.engine_postgres.path
  name                = each.value.sub_role
  db_name             = vault_database_secret_backend_connection.postgres[each.value.connection].name
  username            = each.value.acct
  rotation_period     = each.value.ttl
  rotation_statements = ["ALTER ROLE \"{{username}}\" WITH PASSWORD '{{password}}';"]
}
