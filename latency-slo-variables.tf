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

variable "latency_slo_warning" {
  type    = number
  default = null
}

variable "latency_slo_critical" {
  type    = number
  default = 99.9
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

variable "latency_slo_timeframe" {
  validation {
    condition     = contains(["7d", "30d", "90d"], var.latency_slo_timeframe)
    error_message = "SLO Timeframe can  be 7,30,90 days. Example: 7d."
  }
  type    = string
  default = "30d"
}

variable "latency_slo_burn_rate_priority" {
  description = "Number from 1 (high) to 5 (low)."

  type    = number
  default = 3
}

variable "latency_slo_burn_rate_warning" {
  type    = number
  default = null
}

variable "latency_slo_burn_rate_critical" {
  type    = number
  default = 10 # 10x burn rate
}

variable "latency_slo_burn_rate_note" {
  type    = string
  default = ""
}

variable "latency_slo_burn_rate_docs" {
  type    = string
  default = ""
}

variable "latency_slo_burn_rate_evaluation_period" {
  type    = string
  default = "30d"
}

variable "latency_slo_burn_rate_short_window" {
  type    = string
  default = "5m"
}

variable "latency_slo_burn_rate_long_window" {
  type    = string
  default = "1h"
}

variable "latency_slo_burn_rate_notification_channel_override" {
  type    = string
  default = ""
}

variable "latency_slo_burn_rate_enabled" {
  type    = bool
  default = true
}

variable "latency_slo_burn_rate_alerting_enabled" {
  type    = bool
  default = true
}
