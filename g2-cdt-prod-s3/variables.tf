variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "prevent_destroy" {
  description = "Whether to prevent the destruction of the bucket"
  type        = bool
  default     = false
}


variable "versioning_status" {
  description = "The versioning status of the S3 bucket"
  type        = string
  default     = "Suspended"
}
