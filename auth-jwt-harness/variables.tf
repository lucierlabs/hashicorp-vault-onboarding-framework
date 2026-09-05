variable "auth_jwt_harness_input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/auth-jwt-harness.csv"
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

variable "harness_oidc_discovery_url" {
  type        = string
  description = "Harness OIDC discovery URL and expected JWT issuer"
}

variable "harness_audience" {
  type        = string
  description = "Audience required in Harness JWTs"
}
