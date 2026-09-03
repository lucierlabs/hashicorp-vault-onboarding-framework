variable "input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/auth-approle-vault.csv"
}

variable "token_ttl" {
  type        = number
  description = "Vault token time to live in seconds"
  default     = 14400
}
