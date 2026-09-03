variable "input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/auth-sts-aws.csv"
}

variable "token_ttl" {
  type        = number
  description = "Vault token time to live in seconds"
  default     = 14400
}

variable "vault_aws_access_key_id" {
  type        = string
  description = "AWS access key ID used by Vault to query the AWS APIs"
}

variable "vault_aws_secret_key_wo_version" {
  type        = number
  description = "Version counter used to trigger an update of the write-only AWS secret access key"
  default     = 1
}

variable "cross_account_sts_role_name" {
  type        = string
  description = "Name of the IAM role Vault assumes in each target AWS account to verify login requests"
}
