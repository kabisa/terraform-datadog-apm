locals {
  error_slo_filter = coalesce(
    var.error_slo_filter_override,
    local.filter_str
  )
}


resource "datadog_service_level_objective" "error_slo" {
  count       = var.error_slo_enabled ? 1 : 0
  name        = "${var.service} Errors SLO"
  type        = "metric"
  description = "Errors SLO for ${var.service}"

  thresholds {
    timeframe = var.error_slo_timeframe
    target    = var.error_slo_critical
    warning   = var.error_slo_warning
  }

  query {
    denominator = "sum:trace.${var.trace_span_name}.request.hits{${local.error_slo_filter}}.as_count()"
    numerator   = "sum:trace.${var.trace_span_name}.request.hits.by_http_status{${local.error_slo_filter}}.as_count() - sum:trace.${var.trace_span_name}.request.hits.by_http_status{${local.error_slo_filter},${var.error_slo_error_filter}.as_count()"
  }

  tags = local.normalized_tags
}
