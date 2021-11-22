
resource "datadog_service_level_objective" "slo" {
  count       = var.create_slo ? 1 : 0
  name        = "${var.service} SLO"
  type        = "monitor"
  description = "APM SLO for ${var.service}"
  monitor_ids = concat(
    var.apdex_enabled ? [module.apdex.alert_id] : [],
    (var.error_percentage_enabled && !var.error_slo_enabled) ? [module.error_percentage.alert_id] : [],
    var.latency_enabled ? [module.latency.alert_id] : [],
    var.latency_p95_enabled ? [module.latency_p95.alert_id] : [],
    var.request_rate_enabled ? [module.request_rate.alert_id] : [],
  )

  thresholds {
    timeframe = var.slo_timeframe
    target    = var.slo_critical
    warning   = var.slo_warning
  }

  tags = local.normalized_tags
}
