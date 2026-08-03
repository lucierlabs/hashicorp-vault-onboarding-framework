variable "vault_addr" {
  type        = string
  description = "Address of the HashiCorp Vault server"
  default     = "https://127.0.0.1:8200"
}

variable "input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/auth-jwt-terraform.csv"
}

variable "token_ttl" {
  type        = string
  description = "Token time to live"
  default     = "4h"
}
