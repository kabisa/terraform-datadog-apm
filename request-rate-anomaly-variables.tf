variable "request_rate_anomaly_enabled" {
  type    = bool
  default = false
}

variable "request_rate_anomaly_warning" {
  type    = number
  default = 0.15
}

variable "request_rate_anomaly_critical" {
  type    = number
  default = 0.2
}

variable "request_rate_anomaly_evaluation_period" {
  type    = string
  default = "last_30m"
}


variable "request_rate_anomaly_trigger_window" {
  type    = string
  default = "last_30m"
}


variable "request_rate_anomaly_recovery_window" {
  type    = string
  default = "last_15m"
}

variable "request_rate_anomaly_note" {
  type    = string
  default = ""
}

variable "request_rate_anomaly_docs" {
  type    = string
  default = "Request rate anomaly detection is performed by taking the standard deviation and put a band around it. If X percentage of the requests are outside that band, an alert is raised. https://www.datadoghq.com/blog/introducing-anomaly-detection-datadog/"
}

variable "request_rate_anomaly_filter_override" {
  type    = string
  default = ""
}

variable "request_rate_anomaly_alerting_enabled" {
  type    = bool
  default = true
}

variable "request_rate_anomaly_priority" {
  description = "Number from 1 (high) to 5 (low)."

  type    = number
  default = 3
}

variable "request_rate_anomaly_std_dev_count" {
  type        = number
  description = "Request rate anomaly, how many standard deviations are needed to trigger an alert"
  default     = 5
}
