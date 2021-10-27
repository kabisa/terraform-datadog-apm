variable "env" {
  type = string
}

variable "alert_env" {
  type = string
}

variable "service" {
  type = string
}

variable "trace_span_name" {
  type    = string
  default = "http"

  description = <<-EOT
Traces contain a span name. Example:
  trace.<SPAN_NAME>.<METRIC_SUFFIX>
  trace.<SPAN_NAME>.<METRIC_SUFFIX>.<2ND_PRIM_TAG>_service

The name of the operation or span.name (examples: redis.command, pylons.request, rails.request, mysql.query
https://docs.datadoghq.com/tracing/guide/metrics_namespace/
  EOT
}

variable "notification_channel" {
  type = string
}

variable "additional_tags" {
  type    = list(string)
  default = []
}

variable "name_prefix" {
  type    = string
  default = ""
}

variable "name_suffix" {
  type    = string
  default = ""
}

variable "locked" {
  type    = bool
  default = true
}

variable "create_slo" {
  type    = bool
  default = false
}

variable "slo_warning" {
  type    = number
  default = 99
}

variable "slo_critical" {
  type    = number
  default = 99.9
}

variable "slo_timeframe" {
  validation {
    condition     = contains(["7d", "30d", "90d"], var.slo_timeframe)
    error_message = "SLO Timeframe can  be 7,30,90 days. Example: 7d."
  }
  type    = string
  default = "30d"
}

variable "slo_alerting_enabled" {
  type    = bool
  default = true
}
