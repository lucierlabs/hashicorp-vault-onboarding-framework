resource "vault_mount" "engine_postgres" {
  path = "postgres"
  type = "database"
}
