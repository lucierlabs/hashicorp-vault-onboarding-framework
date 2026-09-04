variable "input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/engine-terraform.csv"
}

variable "vault_terraform_token_wo_version" {
  type        = number
  description = "Version counter used to trigger an update of the write-only HCP Terraform management token"
  default     = 1
}
