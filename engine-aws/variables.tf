variable "engine_aws_input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/engine-aws.csv"
}

variable "environments" {
  type        = set(string)
  description = "CSV environment values handled by this Vault deployment"
  nullable    = false
}

variable "engine_aws_access_key_id" {
  type        = string
  description = "AWS access key ID used by the AWS secrets engine"
}

variable "engine_aws_secret_key_wo_version" {
  type        = number
  description = "Version counter used to trigger an update of the write-only AWS secret access key"
  default     = 1
}
