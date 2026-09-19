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

variable "engine_snowflake_connections" {
  type = map(object({
    connection_url         = string
    username               = string
    private_key_wo_version = optional(number, 1)
  }))
  description = "Snowflake connection configurations keyed by the connection name used in the CSV and admin-kv path"
  nullable    = false
  default     = {}
}
