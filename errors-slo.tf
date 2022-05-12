locals {
  error_slo_filter = coalesce(
    var.error_slo_filter_override,
    local.filter_str
  )
  error_slo_numerator = coalesce(
    var.error_slo_numerator_override,
    "sum:trace.${var.trace_span_name}.hits{${local.error_slo_filter}}.as_count() - sum:trace.${var.trace_span_name}.hits{${local.error_slo_filter}${var.error_slo_error_filter}}.as_count()"
  )
  error_slo_denominator = coalesce(
    var.error_slo_denominator_override,
    "sum:trace.${var.trace_span_name}.hits{${local.error_slo_filter}}.as_count()"
  )
  error_slo_burn_rate_notification_channel = try(coalesce(
    var.error_slo_burn_rate_notification_channel_override,
    var.notification_channel
  ), "")
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

module "error_slo_burn_rate" {
  source  = "kabisa/generic-monitor/datadog"
  version = "0.7.3"

  name  = "${local.service_display_name} - APM - Error SLO - Burn Rate"
  # query = "burn_rate(\"072fdd4535d553ddaaf2ee79f99ef735\").over(\"30d\").long_window(\"1h\").short_window(\"5m\") > 10"
  query            = "avg(${var.error_percentage_evaluation_period}):100 * (sum:trace.${var.trace_span_name}.errors{${local.error_percentage_filter}}.as_rate() / sum:trace.${var.trace_span_name}.hits{${local.error_percentage_filter}}.as_rate() ) > ${var.error_slo_burn_rate_critical}"

  alert_message    = "The latency for service ${local.service_display_name} ({{value}}) has risen above {{threshold}}"
  recovery_message = "The latency for service ${local.service_display_name} ({{value}}) has recovered"
  # type             = "slo alert"

  # monitor level vars
  enabled            = var.error_slo_burn_rate_enabled
  alerting_enabled   = var.error_slo_burn_rate_alerting_enabled
  warning_threshold  = var.error_slo_burn_rate_warning
  critical_threshold = var.error_slo_burn_rate_critical
  priority           = var.error_slo_burn_rate_priority
  docs               = var.error_slo_burn_rate_docs
  note               = var.error_slo_burn_rate_note

  # module level vars
  env                  = var.alert_env
  service              = var.service
  service_display_name = var.service_display_name
  notification_channel = local.error_slo_burn_rate_notification_channel
  additional_tags      = var.additional_tags
  locked               = var.locked
  name_prefix          = var.name_prefix
  name_suffix          = var.name_suffix
}
