resource "datadog_monitor" "online_page_data_http_5xx_errors" {
    for_each = var.http_monitoring.status5xx

    name               = "${var.service}: Watch HTTP 5xx errors on ${each.key}"
    type               = "query alert"
    message            = "High HTTP 5xx errors for ${var.service} on ${each.key} @slack-szdm-online-alerts-${each.key}"

    query = "sum(last_5m):sum:szdm.http_requests.total{service:${var.service},env:${each.key},status:5*} >= ${each.value.threshold_critical}"

    monitor_thresholds {
      warning           = each.value.threshold_warning
      critical          = each.value.threshold_critical
    }

    require_full_window = false

    tags = ["env:${each.key}", "team:${var.team}", "service:${var.service}", "zone:${var.zone}"]
}

resource "datadog_monitor" "online_page_data_http_4xx_errors" {
    for_each = var.http_monitoring.status4xx

    name               = "${var.service}: Watch HTTP 4xx errors on ${each.key}"
    type               = "query alert"
    message            = "High HTTP 4xx errors for ${var.service} on ${each.key} @slack-szdm-online-alerts-${each.key}"

    query = "sum(last_5m):sum:szdm.http_requests.total{service:${var.service},env:${each.key},status:4*} >= ${each.value.threshold_critical}"

    monitor_thresholds {
      warning           = each.value.threshold_warning
      critical          = each.value.threshold_critical
    }

    tags = ["env:${each.key}", "team:${var.team}", "service:${var.service}", "zone:${var.zone}"]
}
