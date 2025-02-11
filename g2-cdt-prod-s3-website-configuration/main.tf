resource "aws_s3_bucket_website_configuration" "this" {
  bucket = var.bucket_id

  index_document {
    suffix = var.website_index_suffix
  }
}

