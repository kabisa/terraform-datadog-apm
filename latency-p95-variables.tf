variable "latency_p95_enabled" {
  type    = bool
  default = true
}

variable "latency_p95_warning" {
  type    = number
  default = 0.9
}

variable "latency_p95_critical" {
  type    = number
  default = 1.3
}

variable "latency_p95_evaluation_period" {
  type    = string
  default = "last_10m"
}

variable "latency_p95_note" {
  type    = string
  default = ""
}

variable "latency_p95_docs" {
  type    = string
  default = ""
}

variable "latency_p95_filter_override" {
  type    = string
  default = ""
}

variable "latency_p95_alerting_enabled" {
  type    = bool
  default = true
}

variable "latency_p95_priority" {
  description = "Number from 1 (high) to 5 (low)."

  type    = number
  default = 3
}
