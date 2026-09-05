variable "auth_jwt_azure_input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/auth-jwt-azure.csv"
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

variable "azure_tenant_id" {
  type        = string
  description = "Microsoft Entra tenant ID that issues the JWTs"
}

variable "azure_audience" {
  type        = string
  description = "Audience required in Microsoft Entra JWTs"
}
