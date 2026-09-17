variable "auth_kerberos_ad_input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/auth-kerberos-ad.csv"
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

variable "active_directory_domains" {
  type = map(object({
    kerberos_service_account          = string
    kerberos_keytab_wo_version        = optional(number, 1)
    kerberos_ldap_url                 = string
    kerberos_ldap_bind_dn             = string
    kerberos_ldap_bindpass_wo_version = optional(number, 1)
    kerberos_ldap_user_dn             = string
    kerberos_group_sam_account_name   = string
    kerberos_ldap_group_dn            = string
    kerberos_upn_domain               = string
  }))
  description = "Active Directory domain configurations keyed by the short domain name used in Vault paths and Terraform state"
  nullable    = false
}
