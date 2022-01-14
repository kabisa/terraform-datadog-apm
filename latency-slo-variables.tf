variable "latency_slo_enabled" {
  type        = bool
  default     = false
  description = "Note that this monitor requires custom metrics to be present. Those can unfortunately not be created with Terraform yet"
}

variable "latency_slo_note" {
  type    = string
  default = ""
}

variable "latency_slo_docs" {
  type    = string
  default = ""
}

variable "latency_slo_filter_override" {
  type    = string
  default = ""
}

variable "latency_slo_alerting_enabled" {
  type    = bool
  default = true
}

variable "latency_slo_status_ok_filter" {
  type        = string
  description = "Filter string to select the non-errors for the latency SLO, Dont forget to include the comma or (AND or OR) keywords"
  default     = ",status:ok"
}

variable "latency_slo_ms_bucket" {
  type        = number
  default     = 250
  description = "We defined several latency buckets with custom metrics based on the APM traces that come in. Our buckets are 100, 250, 500, 1000, 2500, 5000, 10000"
}