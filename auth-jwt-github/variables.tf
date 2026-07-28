variable "vault_addr" {
  type        = string
  description = "Vault address"
  default     = "https://127.0.0.1:8200"
}

variable "input_file" {
  type        = string
  description = "Name of the input file"
  default     = "auth-jwt-github.csv"
}
