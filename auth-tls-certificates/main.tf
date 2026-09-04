resource "vault_auth_backend" "tls_certificates" {
  type = "cert"
  path = "tls-certificates"
}

resource "vault_cert_auth_backend_role" "app_default_role" {
  backend = vault_auth_backend.tls_certificates.path
  name    = "app-default-role"

  certificate = var.trusted_ca_certificate_pem

  allowed_common_names = local.subject_list

  token_policies = []
  token_ttl      = var.token_ttl
}
