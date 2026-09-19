ephemeral "vault_kv_secret_v2" "terraform_secrets" {
  mount = "admin-kv"
  name  = "engine-aws"
}

resource "vault_aws_secret_backend" "aws" {
  path = "aws"

  access_key            = var.engine_aws_access_key_id
  secret_key_wo         = tostring(ephemeral.vault_kv_secret_v2.terraform_secrets.data["secret_key_wo"])
  secret_key_wo_version = var.engine_aws_secret_key_wo_version
}

resource "vault_aws_secret_backend_role" "aws_app_roles" {
  for_each = { for row in local.input_list : row.app_role => row if row.sub == "" }

  backend         = vault_aws_secret_backend.aws.path
  name            = each.value.app_role
  credential_type = "assumed_role"
  role_arns       = ["arn:aws:iam::${each.value.acct_id}:role/${each.value.iam_role}"]
  default_sts_ttl = each.value.ttl
  max_sts_ttl     = each.value.ttl
}

resource "vault_aws_secret_backend_role" "aws_sub_roles" {
  for_each = { for row in local.input_list : row.sub_role => row if row.sub != "" }

  backend         = vault_aws_secret_backend.aws.path
  name            = each.value.sub_role
  credential_type = "assumed_role"
  role_arns       = ["arn:aws:iam::${each.value.acct_id}:role/${each.value.iam_role}"]
  default_sts_ttl = each.value.ttl
  max_sts_ttl     = each.value.ttl
}
