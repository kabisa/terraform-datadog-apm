locals {
  apdex_filter = coalesce(
    var.apdex_filter_override,
    local.filter_str
  )
}

module "apdex" {
  source  = "kabisa/generic-monitor/datadog"
  version = "1.0.0"

  name  = "APM - ${title(split(".", var.trace_span_name)[0])} - Apdex"
  query = "avg(${var.apdex_evaluation_period}):avg:trace.${var.trace_span_name}.apdex.by.service{${local.apdex_filter}} < ${var.apdex_critical}"

  alert_message    = "The ${var.trace_span_name} appdex for service ${local.service_display_name} ({{value}}) has fallen below {{threshold}}"
  recovery_message = "The ${var.trace_span_name} appdex for service ${local.service_display_name} ({{value}}) has recovered"

  # monitor level vars
  enabled            = var.apdex_enabled
  alerting_enabled   = var.apdex_alerting_enabled
  warning_threshold  = var.apdex_warning
  critical_threshold = var.apdex_critical
  priority           = var.apdex_priority
  docs               = var.apdex_docs
  note               = var.apdex_note

  # module level vars
  env                  = var.env
  service              = var.service
  service_display_name = var.service_display_name
  notification_channel = var.notification_channel
  additional_tags      = var.additional_tags
  locked               = var.locked
  name_prefix          = var.name_prefix
  name_suffix          = var.name_suffix
}
