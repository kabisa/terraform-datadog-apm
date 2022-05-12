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
