provider "vault" {
  address = var.vault_addr

  auth_login {
    path = "auth/admin-approle/login"

    parameters = {
      role_id   = "admin-auth-jwt-terraform"
      secret_id = var.admin_approle_secret_id
    }
  }
}
