ephemeral "vault_kv_secret_v2" "terraform_secrets" {
  for_each = var.kubernetes_clusters

  mount = "admin-kv"
  name  = "engine-kubernetes/${each.key}"
}

resource "vault_kubernetes_secret_backend" "kubernetes" {
  for_each = var.kubernetes_clusters

  path = "kubernetes-${each.key}"

  kubernetes_host    = each.value.kubernetes_host
  kubernetes_ca_cert = each.value.kubernetes_ca_cert

  service_account_jwt_wo         = tostring(ephemeral.vault_kv_secret_v2.terraform_secrets[each.key].data["service_account_jwt_wo"])
  service_account_jwt_wo_version = each.value.service_account_jwt_wo_version
}

resource "vault_kubernetes_secret_backend_role" "kubernetes_app_roles" {
  for_each = { for row in local.input_list : row.app_key => row if row.sub == "" }

  backend                       = vault_kubernetes_secret_backend.kubernetes[each.value.cluster].path
  name                          = each.value.app_role
  allowed_kubernetes_namespaces = [each.value.ns]
  service_account_name          = each.value.service_acct
  token_default_ttl             = each.value.ttl
  token_max_ttl                 = each.value.ttl
}

resource "vault_kubernetes_secret_backend_role" "kubernetes_sub_roles" {
  for_each = { for row in local.input_list : row.sub_key => row if row.sub != "" }

  backend                       = vault_kubernetes_secret_backend.kubernetes[each.value.cluster].path
  name                          = each.value.sub_role
  allowed_kubernetes_namespaces = [each.value.ns]
  service_account_name          = each.value.service_acct
  token_default_ttl             = each.value.ttl
  token_max_ttl                 = each.value.ttl
}
