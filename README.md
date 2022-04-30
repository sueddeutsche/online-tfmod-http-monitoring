Terraform module adding Datadog monitors:

- high number of HTTP responses with status 5xx / 4xx for the given service
- high average request time (grouped by request "type")

for the environments "interation", "stage", "prod" and the given "service"

# Usage of module in Terraform code:

    variable "service" {
      type = string
    }

    variable "zone" {
      type = string
    }

    variable "team" {
      type = string
    }

    variable "http_monitoring" {
      type = object({
        status5xx = object({
          integration = object({
            threshold_warning = number
            threshold_critical = number
          })
          stage = object({
            threshold_warning = number
            threshold_critical = number
          })
          prod = object({
            threshold_warning = number
            threshold_critical = number
          })
        })
        status4xx = object({
          integration = object({
            threshold_warning = number
            threshold_critical = number
          })
          stage = object({
            threshold_warning = number
            threshold_critical = number
          })
          prod = object({
            threshold_warning = number
            threshold_critical = number
          })
        })
        avgRequestTimeInMs = object({
          integration = object({
            threshold_warning = number
            threshold_critical = number
          })
          stage = object({
            threshold_warning = number
            threshold_critical = number
          })
          prod = object({
            threshold_warning = number
            threshold_critical = number
          })
        })
      })
    }

    module "http-monitoring" {
      source = "git::git@github.com:sueddeutsche/online-tfmod-http-monitoring.git?ref=v1.0.0"
      service         = var.service
      zone            = var.zone
      team            = var.team
      http_monitoring = var.http_monitoring
    }

# Configuration in Terragrunt:

    inputs = {
      service    = local.app_vars.service
      team       = local.app_vars.team
      zone       = local.app_vars.zone
      http_monitoring = {
        status4xx = {
          integration = {
            threshold_warning = 5
            threshold_critical = 10
          }
          stage = {
            threshold_warning = 50
            threshold_critical = 100
          }
          prod = {
            threshold_warning = 500
            threshold_critical = 1000
          }
        }
        status5xx = {
          integration = {
            threshold_warning = 1
            threshold_critical = 2
          }
          stage = {
            threshold_warning = 1
            threshold_critical = 2
          }
          prod = {
            threshold_warning = 25
            threshold_critical = 50
          }
        }
        avgRequestTimeInMs = {
          integration = {
            threshold_warning = 500
            threshold_critical = 1000
          }
          stage = {
            threshold_warning = 500
            threshold_critical = 1000
          }
          prod = {
            threshold_warning = 500
            threshold_critical = 1000
          }
        }
      }
      ...
    }

    generate "provider_datadog" {
      path      = "provider_datadog_generated.tf"
      if_exists = "overwrite_terragrunt"
      contents  = <<EOF
    variable "datadog_api_key" {
      type        = string
      default     = ""
      description = "Datadog API Key"
    }
    variable "datadog_app_key" {
      type        = string
      default     = ""
      description = "Datadog APP Key"
    }
    provider "datadog" {
      api_key  = var.datadog_api_key
      app_key  = var.datadog_app_key
      api_url  = "https://api.datadoghq.eu/"
      validate = true
    }
    EOF
    }
