

resource "datadog_service_level_objective" "error_slo" {
  count       = var.error_slo_enabled ? 1 : 0
  name        = "${var.service} Errors SLO"
  type        = "monitor"
  description = "Errors SLO for ${var.service}"

  thresholds {
    timeframe = var.error_slo_timeframe
    target    = var.error_slo_critical
    warning   = var.error_slo_warning
  }

  tags = local.normalized_tags
}
