variable "input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/auth-jwt-azure.csv"
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
