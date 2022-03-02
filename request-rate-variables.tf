variable "request_rate_enabled" {
  type    = bool
  default = true
}

variable "request_rate_warning" {
  type    = number
  default = null
}

variable "request_rate_critical" {
  type = number
}

variable "request_rate_evaluation_period" {
  type    = string
  default = "last_30m"
}


variable "request_rate_note" {
  type    = string
  default = ""
}

variable "request_rate_docs" {
  type    = string
  default = "Number of requests per second"
}

variable "request_rate_filter_override" {
  type    = string
  default = ""
}

variable "request_rate_alerting_enabled" {
  type    = bool
  default = true
}

variable "request_rate_priority" {
  description = "Number from 1 (high) to 5 (low)."

  type    = number
  default = 3
}
