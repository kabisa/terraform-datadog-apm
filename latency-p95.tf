module "latency_p95" {
  source = "git@github.com:kabisa/terraform-datadog-generic-monitor.git?ref=terraform-provider-3"

  name = "APM - ${title(split(".", var.trace_span_name)[0])} - Latency(p95)"
  # using same filters as for avg latency
  query = "avg(${var.latency_p95_evaluation_period}):p95:trace.${var.trace_span_name}{${local.latency_filter}} > ${var.latency_p95_critical}"

  alert_message    = "The latency_p95 for service ${local.service_display_name} ({{value}}) has risen above {{threshold}}"
  recovery_message = "The latency_p95 for service ${local.service_display_name} ({{value}}) has recovered"

  # monitor level vars
  enabled            = var.latency_p95_enabled
  alerting_enabled   = var.latency_p95_alerting_enabled
  warning_threshold  = var.latency_p95_warning
  critical_threshold = var.latency_p95_critical
  priority           = var.latency_p95_priority
  docs               = var.latency_p95_docs
  note               = var.latency_p95_note

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

resource "datadog_service_level_objective" "p95_latency_slo" {
  count       = (var.create_slo && var.latency_p95_enabled) ? 1 : 0
  name        = "${local.service_display_name} P95 Latency"
  type        = "monitor"
  description = "APM SLO for ${local.service_display_name}"
  monitor_ids = var.latency_enabled ? [module.latency_p95.alert_id] : []

  thresholds {
    timeframe = var.slo_timeframe
    target    = var.slo_critical
    warning   = var.slo_warning
  }

  tags = concat(local.normalized_tags, ["slo:p95latency"])
}