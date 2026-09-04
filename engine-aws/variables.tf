variable "input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/engine-aws.csv"
}

variable "vault_aws_access_key_id" {
  type        = string
  description = "AWS access key ID used by the AWS secrets engine"
}

variable "vault_aws_secret_key_wo_version" {
  type        = number
  description = "Version counter used to trigger an update of the write-only AWS secret access key"
  default     = 1
}
