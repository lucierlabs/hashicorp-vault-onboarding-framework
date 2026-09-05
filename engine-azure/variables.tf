variable "engine_azure_input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/engine-azure.csv"
}

variable "environments" {
  type        = set(string)
  description = "CSV environment values handled by this Vault deployment"
  nullable    = false
}

variable "azure_subscription_id" {
  type        = string
  description = "Azure subscription ID used by the Azure secrets engine"
}

variable "azure_tenant_id" {
  type        = string
  description = "Microsoft Entra tenant ID used by the Azure secrets engine"
}

variable "engine_azure_client_id" {
  type        = string
  description = "Client ID used by the Azure secrets engine"
}

variable "engine_azure_client_secret_wo_version" {
  type        = number
  description = "Version counter used to trigger an update of the write-only Azure client secret"
  default     = 1
}
