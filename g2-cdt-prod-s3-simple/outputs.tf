output "bucket_name" {
  value       = aws_s3_bucket.this.bucket
  description = "Nombre del bucket S3 creado"
}
