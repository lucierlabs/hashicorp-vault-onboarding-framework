ephemeral "vault_kv_secret_v2" "terraform_secrets" {
  mount = "admin-kv"
  name  = "engine-kubernetes"
}

resource "vault_kubernetes_secret_backend" "kubernetes_lab" {
  path = "kubernetes-lab"

  kubernetes_host    = var.kubernetes_host
  kubernetes_ca_cert = var.kubernetes_ca_cert

  service_account_jwt_wo         = tostring(ephemeral.vault_kv_secret_v2.terraform_secrets.data["service_account_jwt_wo"])
  service_account_jwt_wo_version = var.vault_kubernetes_service_account_jwt_wo_version
}
