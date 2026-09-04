ephemeral "vault_kv_secret_v2" "terraform_secrets" {
  mount = "admin-kv"
  name  = "engine-aws"
}

resource "vault_aws_secret_backend" "aws" {
  path = "aws"

  access_key            = var.vault_aws_access_key_id
  secret_key_wo         = tostring(ephemeral.vault_kv_secret_v2.terraform_secrets.data["secret_key_wo"])
  secret_key_wo_version = var.vault_aws_secret_key_wo_version
}
