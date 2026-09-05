variable "auth_msi_azure_input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/auth-msi-azure.csv"
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
  description = "Microsoft Entra tenant ID used by the Azure auth method"
}

variable "azure_resource_uri" {
  type        = string
  description = "Resource URI of the application registered for Vault in Microsoft Entra"
}

variable "vault_azure_client_id" {
  type        = string
  description = "Client ID used by Vault to query the Azure APIs"
}

variable "vault_azure_client_secret_wo_version" {
  type        = number
  description = "Version counter used to trigger an update of the write-only Azure client secret"
  default     = 1
}
