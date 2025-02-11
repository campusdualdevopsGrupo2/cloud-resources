resource "aws_s3_bucket_versioning" "this" {
  bucket = var.bucket_id

  versioning_configuration {
    status = var.versioning_status
  }
}