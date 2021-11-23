locals {
  request_rate_filter = coalesce(
    var.request_rate_filter_override,
    local.filter_str
  )
}

module "request_rate" {
  source = "git@github.com:kabisa/terraform-datadog-generic-monitor.git?ref=terraform-provider-3"

  name  = "APM - ${title(split(".", var.trace_span_name)[0])} - Request Rate"
  query = "avg(${var.request_rate_evaluation_period}):sum:trace.${var.trace_span_name}.hits{${local.request_rate_filter}}.as_rate() > ${var.request_rate_critical}"

  alert_message    = "The request_rate for service ${local.service_display_name} ({{value}}) has risen above {{threshold}}"
  recovery_message = "The request_rate for service ${local.service_display_name} ({{value}}) has recovered"

  # monitor level vars
  enabled            = var.request_rate_enabled
  alerting_enabled   = var.request_rate_alerting_enabled
  warning_threshold  = var.request_rate_warning
  critical_threshold = var.request_rate_critical
  priority           = var.request_rate_priority
  docs               = var.request_rate_docs
  note               = var.request_rate_note

  # module level vars
  env                  = var.alert_env
  service              = var.service
  service_display_name = var.service_display_name
  notification_channel = var.notification_channel
  additional_tags      = var.additional_tags
  locked               = var.locked
  name_prefix          = var.name_prefix
  name_suffix          = var.name_suffix
}

resource "datadog_service_level_objective" "request_rate_slo" {
  count       = (var.create_slo && var.request_rate_enabled) ? 1 : 0
  name        = "${local.service_display_name} Request Rate"
  type        = "monitor"
  description = "APM SLO for ${local.service_display_name}"
  monitor_ids = var.latency_enabled ? [module.request_rate.alert_id] : []

  thresholds {
    timeframe = var.slo_timeframe
    target    = var.slo_critical
    warning   = var.slo_warning
  }

  tags = concat(local.normalized_tags, ["slo:requestrate"])
}