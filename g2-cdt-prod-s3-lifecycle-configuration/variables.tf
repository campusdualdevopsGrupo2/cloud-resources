variable "bucket_id" {
  type = string
}

variable "lifecycle_rule_id" {
  type = string
}

variable "lifecycle_status" {
  type    = string
  default = "Enabled"
}

variable "lifecycle_expiration_days" {
  type    = number
  default = 30
}