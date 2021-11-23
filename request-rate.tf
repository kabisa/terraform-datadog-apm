locals {
  request_rate_filter = coalesce(
    var.request_rate_filter_override,
    local.filter_str
  )
}

module "request_rate" {
  source = "git@github.com:kabisa/terraform-datadog-generic-monitor.git?ref=terraform-provider-3"

  name  = "APM - ${title(var.trace_span_name)} - Request Rate"
  query = "avg(${var.request_rate_evaluation_period}):sum:trace.servlet.request.hits{${local.request_rate_filter}}.as_rate() > ${var.request_rate_critical}"

  alert_message    = "The request_rate for service ${var.service} ({{value}}) has risen above {{threshold}}"
  recovery_message = "The request_rate for service ${var.service} ({{value}}) has recovered"

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
