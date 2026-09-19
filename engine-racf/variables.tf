variable "engine_racf_input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/engine-racf.csv"
}

variable "environments" {
  type        = set(string)
  description = "CSV environment values handled by this Vault deployment"
  nullable    = false
}

variable "racf_domains" {
  type = map(object({
    ldap_racf_url                   = string
    engine_racf_bind_dn             = string
    engine_racf_bindpass_wo_version = optional(number, 1)
    engine_racf_user_dn             = string
    engine_racf_user_attribute      = optional(string, "racfid")
    engine_racf_password_policy     = string
  }))
  description = "RACF LDAP configurations keyed by the short domain name used in CSV inputs, Vault paths, and Terraform state"
  nullable    = false
}
