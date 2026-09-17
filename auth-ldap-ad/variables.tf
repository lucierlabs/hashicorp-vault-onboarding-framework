variable "auth_ldap_ad_input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/auth-ldap-ad.csv"
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
    ldap_ad_url                    = string
    ldap_ad_bind_dn                = string
    ldap_ad_bindpass_wo_version    = optional(number, 1)
    ldap_ad_user_dn                = string
    ldap_ad_group_sam_account_name = string
    ldap_ad_group_dn               = string
    ldap_ad_upn_domain             = string
  }))
  description = "Active Directory domain configurations keyed by the short domain name used in Vault paths and Terraform state"
  nullable    = false
}
