locals {
  error_percentage_filter = coalesce(
    var.error_percentage_filter_override,
    local.filter_str
  )
}

module "error_percentage" {
  source = "git@github.com:kabisa/terraform-datadog-generic-monitor.git?ref=terraform-provider-3"

  name             = "APM - ${title(var.trace_span_name)} - Error Percentage"
  query            = "avg(${var.error_percentage_evaluation_period}):100 * (sum:trace.${var.trace_span_name}.request.errors{${local.error_percentage_filter}}.as_rate() / sum:trace.${var.trace_span_name}.request.hits{${local.error_percentage_filter}}.as_rate() ) > ${var.error_percentage_critical}"
  alert_message    = "The error percentage for service ${var.service} ({{value}}) has risen above {{threshold}}"
  recovery_message = "The error percentage for service ${var.service} ({{value}}) has recoverd"

  # monitor level vars
  enabled            = var.error_percentage_enabled
  alerting_enabled   = var.error_percentage_alerting_enabled
  warning_threshold  = var.error_percentage_warning
  critical_threshold = var.error_percentage_critical
  priority           = var.error_percentage_priority
  docs               = var.error_percentage_docs
  note               = var.error_percentage_note

  # module level vars
  env                  = var.alert_env
  service              = var.service
  notification_channel = var.notification_channel
  additional_tags      = var.additional_tags
  locked               = var.locked
  name_prefix          = var.name_prefix
  name_suffix          = var.name_suffix
}
