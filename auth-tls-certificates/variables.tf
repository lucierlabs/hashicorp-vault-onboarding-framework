variable "auth_tls_certificates_input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/auth-tls-certificates.csv"
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

variable "trusted_ca_certificate_pem" {
  type        = string
  description = "PEM-encoded trusted CA certificate used by the certificate auth method"
}
