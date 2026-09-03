ephemeral "vault_kv_secret_v2" "terraform_secrets" {
  mount = "admin-kv"
  name  = "auth-sts-aws"
}

resource "vault_auth_backend" "sts_aws" {
  type = "aws"
  path = "sts-aws"
}

resource "vault_aws_auth_backend_client" "sts_aws" {
  backend = vault_auth_backend.sts_aws.path

  access_key            = var.vault_aws_access_key_id
  secret_key_wo         = tostring(ephemeral.vault_kv_secret_v2.terraform_secrets.data["secret_key_wo"])
  secret_key_wo_version = var.vault_aws_secret_key_wo_version
}

resource "vault_aws_auth_backend_config_identity" "sts_aws" {
  backend   = vault_auth_backend.sts_aws.path
  iam_alias = "canonical_arn"
}

resource "vault_aws_auth_backend_sts_role" "cross_account" {
  for_each = toset(local.account_id_list)

  backend    = vault_auth_backend.sts_aws.path
  account_id = each.value
  sts_role   = "arn:aws:iam::${each.value}:role/${var.cross_account_sts_role_name}"
}

resource "vault_aws_auth_backend_role" "app_default_role" {
  count = length(local.input_list) > 0 ? 1 : 0

  backend   = vault_auth_backend.sts_aws.path
  role      = "app-default-role"
  auth_type = "iam"

  bound_iam_principal_arns = local.role_arn_list

  token_policies = []
  token_ttl      = var.token_ttl
}
