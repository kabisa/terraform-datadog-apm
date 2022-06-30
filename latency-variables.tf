variable "latency_enabled" {
  type    = bool
  default = false
}

variable "latency_warning" {
  type    = number
  default = 0.3
}

variable "latency_critical" {
  description = "Latency threshold in seconds for APM traces"
  type        = number
  default     = 0.5
}

variable "latency_evaluation_period" {
  type    = string
  default = "last_10m"
}

variable "latency_note" {
  type    = string
  default = ""
}

variable "latency_docs" {
  type    = string
  default = ""
}

variable "latency_filter_override" {
  type    = string
  default = ""
}

variable "latency_alerting_enabled" {
  type    = bool
  default = true
}

variable "latency_priority" {
  description = "Number from 1 (high) to 5 (low)."

  type    = number
  default = 3
}

variable "latency_notification_channel_override" {
  type    = string
  default = ""
}
