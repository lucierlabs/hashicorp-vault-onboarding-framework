resource "vault_mount" "engine_snowflake" {
  path = "snowflake"
  type = "database"
}
