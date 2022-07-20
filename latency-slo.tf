locals {
  latency_slo_filter = coalesce(
    var.latency_slo_filter_override,
    local.filter_str
  )
  latency_slo_burn_rate_notification_channel = try(coalesce(
    var.latency_slo_burn_rate_notification_channel_override,
    var.notification_channel
  ), "")
  latency_slo_burn_rate_enabled = var.latency_slo_enabled && var.latency_slo_burn_rate_enabled
  latency_slo_id                = local.latency_slo_burn_rate_enabled ? datadog_service_level_objective.latency_slo[0].id : ""

  latency_slo_numerator   = coalesce(var.latency_slo_custom_numerator, "count(v: v<${var.latency_slo_latency_threshold}):trace.${var.trace_span_name}{${local.latency_slo_filter}}")
  latency_slo_denominator = coalesce(var.latency_slo_custom_denominator, "count:trace.${var.trace_span_name}{${local.latency_slo_filter}}")
}


resource "datadog_service_level_objective" "latency_slo" {
  count       = var.latency_slo_enabled ? 1 : 0
  name        = "${local.service_display_name} - APM - Latency SLO"
  type        = "metric"
  description = "Latency SLO for ${local.service_display_name}"

  thresholds {
    timeframe = var.latency_slo_timeframe
    target    = var.latency_slo_critical
    warning   = var.latency_slo_warning
  }

  query {
    numerator   = local.latency_slo_numerator
    denominator = local.latency_slo_denominator
  }

  tags = local.normalized_tags
}


module "latency_slo_burn_rate" {
  source  = "kabisa/generic-monitor/datadog"
  version = "1.0.0"

  name  = "APM - Latency SLO - Burn Rate"
  query = "burn_rate(\"${local.latency_slo_id}\").over(\"${var.latency_slo_burn_rate_evaluation_period}\").long_window(\"${var.latency_slo_burn_rate_long_window}\").short_window(\"${var.latency_slo_burn_rate_short_window}\") > ${var.latency_slo_burn_rate_critical}"


  alert_message    = "${local.service_display_name} service is burning through its Latency Budget. The percentage of slow requests is {{threshold}}x higher than expected"
  recovery_message = "${local.service_display_name} service burn rate has recovered"
  type             = "slo alert"

  # monitor level vars
  enabled            = local.latency_slo_burn_rate_enabled
  alerting_enabled   = var.latency_slo_burn_rate_alerting_enabled
  warning_threshold  = var.latency_slo_burn_rate_warning
  critical_threshold = var.latency_slo_burn_rate_critical
  priority           = var.latency_slo_burn_rate_priority
  docs               = var.latency_slo_burn_rate_docs
  note               = var.latency_slo_burn_rate_note

  # module level vars
  env                  = var.env
  service              = var.service
  service_display_name = var.service_display_name
  notification_channel = local.latency_slo_burn_rate_notification_channel
  additional_tags      = var.additional_tags
  locked               = var.locked
  name_prefix          = var.name_prefix
  name_suffix          = var.name_suffix
}
