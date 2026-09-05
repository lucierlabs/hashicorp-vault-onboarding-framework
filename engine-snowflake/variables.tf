variable "engine_snowflake_input_file" {
  type        = string
  description = "Name of the input file"
  default     = "../input-files/engine-snowflake.csv"
}

variable "environments" {
  type        = set(string)
  description = "CSV environment values handled by this Vault deployment"
  nullable    = false
}
