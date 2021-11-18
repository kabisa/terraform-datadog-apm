variable "error_slo_enabled" {
  type    = bool
  default = true
}

variable "error_slo_warning" {
  type    = number
  default = 99.95
}

variable "error_slo_critical" {
  type    = number
  default = 99.9
}

variable "error_slo_timeframe" {
  validation {
    condition     = contains(["7d", "30d", "90d"], var.error_slo_timeframe)
    error_message = "SLO Timeframe can  be 7,30,90 days. Example: 7d."
  }
  type    = string
  default = "30d"
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

variable "error_slo_alerting_enabled" {
  type    = bool
  default = true
}

variable "error_slo_priority" {
  description = "Number from 1 (high) to 5 (low)."

  type    = number
  default = 2
}
