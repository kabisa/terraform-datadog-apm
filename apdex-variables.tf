variable "apdex_enabled" {
  type    = bool
  default = true
}

variable "apdex_warning" {
  type    = number
  default = 0.9
}

variable "apdex_critical" {
  type    = number
  default = 0.8
}

variable "apdex_evaluation_period" {
  type    = string
  default = "last_10m"
}

variable "apdex_note" {
  type    = string
  default = ""
}

variable "apdex_docs" {
  type    = string
  default = <<-EOT
    Apdex is a measure of response time based against a set threshold. It measures the ratio of satisfactory response times to unsatisfactory response times. The response time is measured from an asset request to completed delivery back to the requestor. For more see: https://en.wikipedia.org/wiki/Apdex#Apdex_method
  EOT
}

variable "apdex_filter_override" {
  type    = string
  default = ""
}

variable "apdex_alerting_enabled" {
  type    = bool
  default = true
}

variable "apdex_priority" {
  description = "Number from 1 (high) to 5 (low)."

  type    = number
  default = 3
}
