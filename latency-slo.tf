locals {
  latency_slo_filter = coalesce(
    var.latency_slo_filter_override,
    local.filter_str
  )
  latency_slo_burn_rate_notification_channel = try(coalesce(
    var.latency_slo_burn_rate_notification_channel_override,
    var.notification_channel
  ), "")
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
    numerator   = "sum:custom_trace.lt.${var.latency_slo_ms_bucket}ms.count{${local.latency_slo_filter}${var.latency_slo_status_ok_filter}}.as_count()"
    denominator = "sum:custom_trace.hits{${local.latency_slo_filter}${var.latency_slo_status_ok_filter}}.as_count()"
  }

  tags = local.normalized_tags
}


module "latency_slo_burn_rate" {
  source  = "kabisa/generic-monitor/datadog"
  version = "0.7.4"

  name  = "${local.service_display_name} - APM - Error SLO - Burn Rate"
  query = "burn_rate(\"${datadog_service_level_objective.latency_slo[0].id}\").over(\"${var.latency_slo_burn_rate_evaluation_period}\").long_window(\"${var.latency_slo_burn_rate_long_window}\").short_window(\"${var.latency_slo_burn_rate_short_window}\") > ${var.latency_slo_burn_rate_critical}"


  alert_message    = "${local.service_display_name} service is burning through its Error Budget. The percentage of 5XX status codes is {{threshold}}x higher than expected"
  recovery_message = "${local.service_display_name} service burn rate has recovered"
  type             = "slo alert"

  # monitor level vars
  enabled            = var.latency_slo_enabled && var.latency_slo_burn_rate_enabled
  alerting_enabled   = var.latency_slo_burn_rate_alerting_enabled
  warning_threshold  = var.latency_slo_burn_rate_warning
  critical_threshold = var.latency_slo_burn_rate_critical
  priority           = var.latency_slo_burn_rate_priority
  docs               = var.latency_slo_burn_rate_docs
  note               = var.latency_slo_burn_rate_note

  # module level vars
  env                  = var.alert_env
  service              = var.service
  service_display_name = var.service_display_name
  notification_channel = local.latency_slo_burn_rate_notification_channel
  additional_tags      = var.additional_tags
  locked               = var.locked
  name_prefix          = var.name_prefix
  name_suffix          = var.name_suffix
}
