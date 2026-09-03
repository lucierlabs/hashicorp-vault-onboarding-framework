variable "input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/auth-oidc-okta.csv"
}

variable "token_ttl" {
  type        = number
  description = "Vault token time to live in seconds"
  default     = 14400
}

variable "okta_domain" {
  type        = string
  description = "Okta tenant domain without a URL scheme"
}

variable "okta_oidc_client_id" {
  type        = string
  description = "Client ID of the Vault OIDC application in Okta"
}

variable "okta_oidc_client_secret_wo_version" {
  type        = number
  description = "Version counter used to trigger an update of the write-only Okta OIDC client secret"
  default     = 1
}

variable "vault_addr" {
  type        = string
  description = "Externally accessible Vault address used in the OIDC callback URL"
}
