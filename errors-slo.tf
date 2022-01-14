locals {
  error_slo_filter = coalesce(
    var.error_slo_filter_override,
    local.filter_str
  )
}


resource "datadog_service_level_objective" "error_slo" {
  count       = var.error_slo_enabled ? 1 : 0
  name        = "${local.service_display_name} Errors"
  type        = "metric"
  description = "Errors SLO for ${local.service_display_name}"

  thresholds {
    timeframe = var.error_slo_timeframe
    target    = var.error_slo_critical
    warning   = var.error_slo_warning
  }

  query {
    denominator = "sum:trace.${var.trace_span_name}.hits{${local.error_slo_filter}}.as_count()"
    numerator   = "sum:trace.${var.trace_span_name}.hits{${local.error_slo_filter}}.as_count() - sum:trace.${var.trace_span_name}.hits{${local.error_slo_filter}${var.error_slo_error_filter}}.as_count()"
  }

  tags = local.normalized_tags
}
