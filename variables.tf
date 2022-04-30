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
