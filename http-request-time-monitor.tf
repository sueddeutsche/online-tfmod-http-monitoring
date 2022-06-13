resource "datadog_monitor" "online_page_data_http_high_request_time" {
    for_each = var.http_monitoring.avgRequestTimeInMs

    name               = "${var.service}: Watch avg HTTP request time on ${each.key}"
    type               = "query alert"
    message            = "High avg HTTP request time for ${var.service} on ${each.key} @slack-szdm-online-alerts-${each.key}"

    query = "avg(last_5m):avg:szdm.http_requests.avg{service:${var.service},env:${each.key}} by {type} >= ${each.value.threshold_critical}"

    monitor_thresholds {
      warning           = each.value.threshold_warning
      critical          = each.value.threshold_critical
    }

    tags = ["env:${each.key}", "team:${var.team}", "service:${var.service}", "zone:${var.zone}"]
}
