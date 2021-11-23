locals {
  latency_exclusion_str  = join(",", [for exclusion in var.latency_excluded_resource_names : "!resource_name:${exclusion}"])
  default_latency_filter = local.latency_exclusion_str != "" ? "${local.filter_str},${local.latency_exclusion_str}" : local.filter_str
  # Override takes precedence
  latency_filter = coalesce(
    var.latency_filter_override,
    local.default_latency_filter
  )
}

module "latency" {
  source = "git@github.com:kabisa/terraform-datadog-generic-monitor.git?ref=0.6.5"

  name  = "APM - ${title(split(".", var.trace_span_name)[0])} - Latency"
  query = "avg(${var.latency_evaluation_period}):avg:trace.${var.trace_span_name}{${local.latency_filter}} > ${var.latency_critical}"

  alert_message    = "The latency for service ${local.service_display_name} ({{value}}) has risen above {{threshold}}"
  recovery_message = "The latency for service ${local.service_display_name} ({{value}}) has recovered"

  # monitor level vars
  enabled            = var.latency_enabled
  alerting_enabled   = var.latency_alerting_enabled
  warning_threshold  = var.latency_warning
  critical_threshold = var.latency_critical
  priority           = var.latency_priority
  docs               = var.latency_docs
  note               = var.latency_note

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

resource "datadog_service_level_objective" "average_latency_slo" {
  count       = (var.create_slo && var.latency_enabled) ? 1 : 0
  name        = "${local.service_display_name} Average Latency"
  type        = "monitor"
  description = "APM SLO for ${local.service_display_name}"
  monitor_ids = var.latency_enabled ? [module.latency.alert_id] : []

  thresholds {
    timeframe = var.slo_timeframe
    target    = var.slo_critical
    warning   = var.slo_warning
  }

  tags = concat(local.normalized_tags, ["slo:avglatency"])
}