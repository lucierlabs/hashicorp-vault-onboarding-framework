variable "input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/auth-jwt-harness.csv"
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
