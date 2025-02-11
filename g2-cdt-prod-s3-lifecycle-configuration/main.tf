resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = var.bucket_id

  rule {
    id     = var.lifecycle_rule_id
    status = var.lifecycle_status

    expiration {
      days = var.lifecycle_expiration_days
    }
  }
}


