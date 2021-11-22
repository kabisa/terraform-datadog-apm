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

variable "error_slo_alerting_enabled" {
  type    = bool
  default = true
}
