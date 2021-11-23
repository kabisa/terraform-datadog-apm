variable "env" {
  type = string
}

variable "alert_env" {
  type = string
}

variable "service" {
  type = string
}

variable "service_display_name" {
  type    = string
  default = null
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
  default = true
}

variable "slo_warning" {
  type    = number
  default = null
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

variable "latency_excluded_resource_names" {
  type        = list(string)
  description = "List of resource names to exclude in latency oriented monitors or SLOs. Some requests might be batch requests"
  default     = []
}

variable "filters_str_override" {
  type    = string
  default = null
}

variable "error_slo_error_filter" {
  type        = string
  description = "Filter string to select the errors for the error SLO, Dont forget to include the comma or (AND or OR) keywords"
  default     = ",http.status_code:5*"
}