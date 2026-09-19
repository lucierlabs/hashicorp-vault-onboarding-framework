resource "vault_mount" "engine_mysql" {
  path = "mysql"
  type = "database"
}

ephemeral "vault_kv_secret_v2" "terraform_secrets" {
  for_each = local.active_connections

  mount = "admin-kv"
  name  = "engine-mysql/${each.key}"
}

resource "vault_database_secret_backend_connection" "mysql" {
  for_each = local.active_connections

  backend       = vault_mount.engine_mysql.path
  name          = each.key
  plugin_name   = "mysql-database-plugin"
  allowed_roles = local.connection_roles[each.key]

  mysql {
    connection_url      = each.value.connection_url
    username            = each.value.username
    password_wo         = tostring(ephemeral.vault_kv_secret_v2.terraform_secrets[each.key].data["password_wo"])
    password_wo_version = each.value.password_wo_version
  }
}

resource "vault_database_secret_backend_static_role" "mysql_app_roles" {
  for_each = { for row in local.input_list : row.app_role => row if row.sub == "" }

  backend             = vault_mount.engine_mysql.path
  name                = each.value.app_role
  db_name             = vault_database_secret_backend_connection.mysql[each.value.connection].name
  username            = each.value.acct
  rotation_period     = each.value.ttl
  rotation_statements = ["ALTER USER '{{username}}'@'%' IDENTIFIED BY '{{password}}';"]
}

resource "vault_database_secret_backend_static_role" "mysql_sub_roles" {
  for_each = { for row in local.input_list : row.sub_role => row if row.sub != "" }

  backend             = vault_mount.engine_mysql.path
  name                = each.value.sub_role
  db_name             = vault_database_secret_backend_connection.mysql[each.value.connection].name
  username            = each.value.acct
  rotation_period     = each.value.ttl
  rotation_statements = ["ALTER USER '{{username}}'@'%' IDENTIFIED BY '{{password}}';"]
}
