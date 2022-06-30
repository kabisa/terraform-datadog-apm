variable "error_percentage_enabled" {
  description = "We prefer to alert on SLO's"
  type        = bool
  default     = false
}

variable "error_percentage_warning" {
  type    = number
  default = 0.01
}

variable "error_percentage_critical" {
  type    = number
  default = 0.05
}

variable "error_percentage_evaluation_period" {
  type    = string
  default = "last_10m"
}

variable "error_percentage_note" {
  type    = string
  default = ""
}

variable "error_percentage_docs" {
  type    = string
  default = ""
}

variable "error_percentage_filter_override" {
  type    = string
  default = ""
}

variable "error_percentage_alerting_enabled" {
  type    = bool
  default = true
}

variable "error_percentage_priority" {
  description = "Number from 1 (high) to 5 (low)."

  type    = number
  default = 3
}
