
output "monitor_ids" {
  value = concat(
    var.apdex_enabled ? [module.apdex.alert_id] : [],
    var.error_percentage_enabled ? [module.error_percentage.alert_id] : [],
    var.latency_enabled ? [module.latency.alert_id] : [],
    var.latency_p95_enabled ? [module.latency_p95.alert_id] : [],
    var.request_rate_enabled ? [module.request_rate.alert_id] : [],
  )
}
