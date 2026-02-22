
variable "dt_client_secret" {
  description = "Dynatrace Client Secret"
  type        = string
  sensitive   = true
}

variable "dt_api_token" {
  description = "Dynatrace API Token"
  type        = string
  sensitive   = true
}
