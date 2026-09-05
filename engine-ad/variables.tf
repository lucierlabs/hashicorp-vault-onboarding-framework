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

variable "ldap_ad_url" {
  type        = string
  description = "URL of the Active Directory LDAP server"
}

variable "engine_ad_bind_dn" {
  type        = string
  description = "Bind distinguished name used by the Active Directory secrets engine"
}

variable "engine_ad_bindpass_wo_version" {
  type        = number
  description = "Version counter used to trigger an update of the write-only Active Directory bind password"
  default     = 1
}

variable "engine_ad_user_dn" {
  type        = string
  description = "Base distinguished name containing the Active Directory users managed by Vault"
}
