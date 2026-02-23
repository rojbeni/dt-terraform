terraform {
  required_providers {
    dynatrace = {
      source  = "dynatrace-oss/dynatrace"
      version = "~> 1.0"
    }
  }
}

provider "dynatrace" {
  dt_env_url    = "https://gdg16975.live.dynatrace.com"
  client_id     = "dt0s02.QYHZDA26"
  client_secret = var.dt_client_secret
  account_id    = "urn:dtaccount:c1cfaa1c-0d18-4916-b4b7-08e0855be7e1"
  dt_api_token  = var.dt_api_token
}
