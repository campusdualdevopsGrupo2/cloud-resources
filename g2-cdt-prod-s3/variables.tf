variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "prevent_destroy" {
  description = "Whether to prevent the destruction of the bucket"
  type        = bool
  default     = false
}
variable "versioning" {
  description = "Whether to prevent the destruction of the bucket"
  type        = bool
  default     = false
}

variable "versioning_status" {
  description = "The versioning status of the S3 bucket"
  type        = string
  default     = "Suspended"
}

variable "lifecycle_rule_id" {
  description = "The ID of the lifecycle rule"
  type        = string
  default     = "rule-1"
}

variable "lifecycle_status" {
  description = "The status of the lifecycle rule"
  type        = string
  default     = "Enabled"
}

variable "lifecycle_expiration_days" {
  description = "The number of days after which objects are deleted"
  type        = number
  default     = 30
}

variable "website_index_suffix" {
  description = "The index document for the S3 website configuration"
  type        = string
  default     = "index.html"
}

variable "block_public_acls" {
  description = "Whether to block public ACLs"
  type        = bool
  default     = false
}

variable "block_public_policy" {
  description = "Whether to block public policies"
  type        = bool
  default     = false
}

variable "ignore_public_acls" {
  description = "Whether to ignore public ACLs"
  type        = bool
  default     = false
}

variable "restrict_public_buckets" {
  description = "Whether to restrict public buckets"
  type        = bool
  default     = false
}
