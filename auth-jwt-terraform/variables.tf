variable "auth_jwt_terraform_input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/auth-jwt-terraform.csv"
}

variable "admin_approle_secret_id" {
  type        = string
  description = "SecretID for the admin-auth-jwt-terraform bootstrap AppRole"
  sensitive   = true
  nullable    = false
}

variable "vault_addr" {
  type        = string
  description = "Address of the HashiCorp Vault server"
  nullable    = false
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

variable "auth_jwt_terraform_admin_input_file" {
  type        = string
  description = "Name of the admin input file"
  default     = "../input-files/admin-roles.csv"
}

variable "engine_identity_terraform_full_workspace" {
  type        = string
  description = "Full workspace identifier for the engine-identity workspace"
}
