variable "engine_ad_input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/engine-ad.csv"
}

variable "environments" {
  type        = set(string)
  description = "CSV environment values handled by this Vault deployment"
  nullable    = false
}

variable "active_directory_domains" {
  type = map(object({
    ldap_ad_url                   = string
    engine_ad_bind_dn             = string
    engine_ad_bindpass_wo_version = optional(number, 1)
    engine_ad_user_dn             = string
  }))
  description = "Active Directory domain configurations keyed by the short domain name used in Vault paths and Terraform state"
  nullable    = false
}
