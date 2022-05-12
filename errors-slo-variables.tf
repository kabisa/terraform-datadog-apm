variable "error_slo_enabled" {
  type    = bool
  default = true
}

variable "error_slo_note" {
  type    = string
  default = ""
}

variable "error_slo_docs" {
  type    = string
  default = ""
}

variable "error_slo_filter_override" {
  type    = string
  default = ""
}

variable "error_slo_warning" {
  type    = number
  default = null
}

variable "error_slo_critical" {
  type    = number
  default = 99.9
}

variable "error_slo_alerting_enabled" {
  type    = bool
  default = true
}

variable "error_slo_error_filter" {
  type        = string
  description = "Filter string to select the non-errors for the SLO, Dont forget to include the comma or (AND or OR) keywords"
  default     = ",status:error"
}

variable "error_slo_timeframe" {
  validation {
    condition     = contains(["7d", "30d", "90d"], var.error_slo_timeframe)
    error_message = "SLO Timeframe can  be 7,30,90 days. Example: 7d."
  }
  type    = string
  default = "30d"
}

variable "error_slo_numerator_override" {
  type    = string
  default = ""
}

variable "error_slo_denominator_override" {
  type    = string
  default = ""
}

variable "error_slo_burn_rate_notification_channel_override" {
  type    = string
  default = ""
}

variable "error_slo_burn_rate_enabled" {
  type    = bool
  default = true
}

variable "error_slo_burn_rate_alerting_enabled" {
  type    = bool
  default = true
}

variable "error_slo_burn_rate_priority" {
  description = "Number from 1 (high) to 5 (low)."

  type    = number
  default = 3
}

variable "error_slo_burn_rate_warning" {
  type    = number
  default = null
}

variable "error_slo_burn_rate_critical" {
  type    = number
  default = 10 # 10x burn rate
}

variable "error_slo_burn_rate_note" {
  type    = string
  default = ""
}

variable "error_slo_burn_rate_docs" {
  type    = string
  default = ""
}

variable "error_slo_burn_rate_evaluation_period" {
  type    = string
  default = "30d"
}

variable "error_slo_burn_rate_short_window" {
  type    = string
  default = "5m"
}

variable "error_slo_burn_rate_long_window" {
  type    = string
  default = "1h"
}