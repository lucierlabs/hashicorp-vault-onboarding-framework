variable "auth_ldap_racf_input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/auth-ldap-racf.csv"
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

variable "racf_domains" {
  type = map(object({
    ldap_racf_url                 = string
    ldap_racf_bind_dn             = string
    ldap_racf_bindpass_wo_version = optional(number, 1)
    ldap_racf_user_dn             = string
    ldap_racf_user_attribute      = string
    ldap_racf_user_filter         = string
    ldap_racf_group_dn            = string
    ldap_racf_group_filter        = string
    ldap_racf_group_attribute     = string
  }))
  description = "RACF LDAP configurations keyed by the short domain name used in Vault paths and Terraform state"
  nullable    = false
}
