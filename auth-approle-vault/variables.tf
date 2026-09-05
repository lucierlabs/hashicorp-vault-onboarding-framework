variable "auth_approle_vault_input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/auth-approle-vault.csv"
}

variable "environments" {
  type        = set(string)
  description = "CSV environment values handled by this Vault deployment"
  nullable    = false
}

variable "token_ttl" {
  type        = number
  description = "Vault token time to live in seconds"
  default     = 14400
}
