locals {
  request_rate_anomaly_filter = coalesce(
    var.request_rate_anomaly_filter_override,
    local.filter_str
  )
}

module "request_rate_anomaly" {
  source = "git@github.com:kabisa/terraform-datadog-generic-monitor.git?ref=terraform-provider-3"

  name  = "APM - ${title(split(".", var.trace_span_name)[0])} - Request Rate Anomaly"
  query = "avg(${var.request_rate_anomaly_evaluation_period}):anomalies(sum:trace.${var.trace_span_name}.hits{${local.request_rate_anomaly_filter}}.as_rate(), 'agile', ${var.request_rate_anomaly_std_dev_count}, direction='both', alert_window='${var.request_rate_anomaly_trigger_window}', interval=60, count_default_zero='false', seasonality='weekly') > ${var.request_rate_anomaly_critical}"

  alert_message    = "The request_rate_anomaly for service ${local.service_display_name} ({{value}}) has risen above {{threshold}}"
  recovery_message = "The request_rate_anomaly for service ${local.service_display_name} ({{value}}) has recovered"

  anomaly_recovery_window = var.request_rate_anomaly_recovery_window
  anomaly_trigger_window  = var.request_rate_anomaly_trigger_window

  # monitor level vars
  enabled            = var.request_rate_anomaly_enabled
  alerting_enabled   = var.request_rate_anomaly_alerting_enabled
  warning_threshold  = var.request_rate_anomaly_warning
  critical_threshold = var.request_rate_anomaly_critical
  priority           = var.request_rate_anomaly_priority
  docs               = var.request_rate_anomaly_docs
  note               = var.request_rate_anomaly_note

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
