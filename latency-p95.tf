locals {
  latency_p95_filter = coalesce(
    var.latency_p95_filter_override,
    local.filter_str
  )
}

module "latency_p95" {
  source = "git@github.com:kabisa/terraform-datadog-generic-monitor.git?ref=0.6.2"

  name  = "APM - ${title(var.trace_span_name)} - Latency(p95)"
  query = "avg(${var.latency_p95_evaluation_period}):p95:trace.${var.trace_span_name}.request{${local.latency_p95_filter}} > ${var.latency_p95_critical}"

  alert_message    = "The latency_p95 for service ${var.service} ({{value}}) has risen above {{threshold}}"
  recovery_message = "The latency_p95 for service ${var.service} ({{value}}) has recovered"

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
  notification_channel = var.notification_channel
  additional_tags      = var.additional_tags
  locked               = var.locked
  name_prefix          = var.name_prefix
  name_suffix          = var.name_suffix
}
