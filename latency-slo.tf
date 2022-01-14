locals {
  latency_slo_filter = coalesce(
    var.latency_slo_filter_override,
    local.filter_str
  )
}


resource "datadog_service_level_objective" "latency_slo" {
  count       = var.latency_slo_enabled ? 1 : 0
  name        = "${local.service_display_name} latencys"
  type        = "metric"
  description = "latencys SLO for ${local.service_display_name}"

  thresholds {
    timeframe = var.slo_timeframe
    target    = var.slo_critical
    warning   = var.slo_warning
  }

  query {
    denominator = "sum:custom_trace.lt.${var.latency_slo_ms_bucket}ms.count{${local.latency_slo_filter}${var.latency_slo_status_ok_filter}}.as_count()"
    numerator   = "sum:custom_trace.hits{${local.latency_slo_filter}${var.latency_slo_status_ok_filter}}.as_count()"
  }

  tags = local.normalized_tags
}