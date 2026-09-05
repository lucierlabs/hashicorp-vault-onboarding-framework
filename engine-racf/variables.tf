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
