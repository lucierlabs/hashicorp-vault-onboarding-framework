resource "vault_mount" "kv" {
  path        = "kv"
  type        = "kv"
  options     = { version = "2" }
  description = "KV Version 2 secret engine mount"
}

resource "vault_kv_secret_backend_v2" "kv_backend" {
  mount        = vault_mount.kv.path
  max_versions = 10
}

resource "vault_mount" "admin_kv" {
  path        = "admin-kv"
  type        = "kv"
  options     = { version = "2" }
  description = "Admin KV Version 2 secret engine mount"
}

resource "vault_kv_secret_backend_v2" "admin_kv_backend" {
  mount        = vault_mount.admin_kv.path
  max_versions = 10
}