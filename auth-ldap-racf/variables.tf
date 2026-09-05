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

variable "racf_domain" {
  type        = string
  description = "Domain component used in the RACF LDAP secret path"
}

variable "racf_ldap_url" {
  type        = string
  description = "URL of the RACF LDAP server"
}

variable "racf_ldap_bind_dn" {
  type        = string
  description = "Bind distinguished name used to query RACF LDAP"
}

variable "racf_ldap_bindpass_wo_version" {
  type        = number
  description = "Version counter used to trigger an update of the write-only RACF LDAP bind password"
  default     = 1
}

variable "racf_ldap_user_dn" {
  type        = string
  description = "Base distinguished name used to search for RACF users"
}

variable "racf_user_attribute" {
  type        = string
  description = "LDAP attribute used to match RACF usernames"
}

variable "racf_user_filter" {
  type        = string
  description = "LDAP filter used to find RACF users"
}

variable "racf_ldap_group_dn" {
  type        = string
  description = "Base distinguished name used to search for RACF groups"
}

variable "racf_group_filter" {
  type        = string
  description = "LDAP filter used to determine RACF group membership"
}

variable "racf_group_attribute" {
  type        = string
  description = "LDAP attribute used as the RACF group name"
}
