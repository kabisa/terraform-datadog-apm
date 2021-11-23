module "latency_p95" {
  source = "git@github.com:kabisa/terraform-datadog-generic-monitor.git?ref=terraform-provider-3"

  name = "APM - ${title(split(".", var.trace_span_name)[0])} - Latency(p95)"
  # using same filters as for avg latency
  query = "avg(${var.latency_p95_evaluation_period}):p95:trace.${var.trace_span_name}{${local.latency_filter}} > ${var.latency_p95_critical}"

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
  service_display_name = var.service_display_name
  notification_channel = var.notification_channel
  additional_tags      = var.additional_tags
  locked               = var.locked
  name_prefix          = var.name_prefix
  name_suffix          = var.name_suffix
}
