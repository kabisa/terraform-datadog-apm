

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
    denominator = "sum:trace.${var.trace_span_name}.request.hits{${local.default_latency_filter}}.as_count()"
    numerator   = "sum:trace.${var.trace_span_name}.request.hits.by_http_status{${local.default_latency_filter}}.as_count() - sum:trace.${var.trace_span_name}.request.hits.by_http_status{service:bff-service,resource_name:post_/api/user/login,http.status_class:5xx,env:prd}.as_count()"
  }

  tags = local.normalized_tags
}
