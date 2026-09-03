variable "input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/auth-ldap-ad.csv"
}

variable "token_ttl" {
  type        = number
  description = "Vault token time to live in seconds"
  default     = 14400
}

variable "ldap_ad_url" {
  type        = string
  description = "URL of the Active Directory LDAP server"
}

variable "ldap_ad_bind_dn" {
  type        = string
  description = "Bind distinguished name used to query Active Directory"
}

variable "ldap_ad_bindpass_wo_version" {
  type        = number
  description = "Version counter used to trigger an update of the write-only Active Directory bind password"
  default     = 1
}

variable "ldap_ad_user_dn" {
  type        = string
  description = "Base distinguished name used to search for Active Directory users"
}

variable "ldap_ad_group_sam_account_name" {
  type        = string
  description = "sAMAccountName of the Active Directory group permitted to authenticate with LDAP"
}

variable "ldap_ad_group_dn" {
  type        = string
  description = "Base distinguished name used to search for Active Directory groups"
}

variable "ldap_ad_upn_domain" {
  type        = string
  description = "User principal name domain for Active Directory authentication"
}
