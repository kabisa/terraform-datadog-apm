locals {
  error_slo_filter = coalesce(
    var.error_slo_filter_override,
    local.filter_str
  )
  error_slo_numerator = coalesce(
    var.error_slo_numerator_override,
    "sum:trace.${var.trace_span_name}.request.hits{${local.error_slo_filter}}.as_count() - sum:trace.${var.trace_span_name}.request.hits{${local.error_slo_filter}${var.error_slo_error_filter}}.as_count()"
  )
  error_slo_denominator = coalesce(
    var.error_slo_denominator_override,
    "sum:trace.${var.trace_span_name}.request.hits{${local.error_slo_filter}}.as_count()"
  )
}


resource "datadog_service_level_objective" "error_slo" {
  count       = var.error_slo_enabled ? 1 : 0
  name        = "${local.service_display_name} - APM - Error SLO"
  type        = "metric"
  description = "Errors SLO for ${local.service_display_name}"

  thresholds {
    timeframe = var.error_slo_timeframe
    target    = var.error_slo_critical
    warning   = var.error_slo_warning
  }

  query {
    numerator   = local.error_slo_numerator
    denominator = local.error_slo_denominator
  }

  tags = local.normalized_tags
}
