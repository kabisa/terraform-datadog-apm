locals {
  latency_filter = coalesce(
    var.latency_filter_override,
    local.filter_str
  )
}

module "latency" {
  source = "git@github.com:kabisa/terraform-datadog-generic-monitor.git?ref=0.6.2"

  name  = "APM - ${title(var.trace_span_name)} - Latency"
  query = "avg(${var.latency_evaluation_period}):avg:trace.${var.trace_span_name}.request{${local.latency_filter}} > ${var.latency_critical}"

  alert_message    = "The latency for service ${var.service} ({{value}}) has risen above {{threshold}}"
  recovery_message = "The latency for service ${var.service} ({{value}}) has recovered"

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
  notification_channel = var.notification_channel
  additional_tags      = var.additional_tags
  locked               = var.locked
  name_prefix          = var.name_prefix
  name_suffix          = var.name_suffix
}
