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
  default = "http.request"

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

variable "latency_excluded_resource_names" {
  type        = list(string)
  description = "List of resource names to exclude in latency oriented monitors or SLOs. Some requests might be batch requests"
  default     = []
}

variable "filters_str_override" {
  type    = string
  default = null
}
