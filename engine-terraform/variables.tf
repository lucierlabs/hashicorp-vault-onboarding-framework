variable "engine_terraform_input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/engine-terraform.csv"
}

variable "environments" {
  type        = set(string)
  description = "CSV environment values handled by this Vault deployment"
  nullable    = false
}

variable "vault_terraform_token_wo_version" {
  type        = number
  description = "Version counter used to trigger an update of the write-only HCP Terraform management token"
  default     = 1
}
