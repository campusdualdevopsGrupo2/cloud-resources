output "db_instance_endpoint" {
  description = "Endpoint de la instancia RDS"
  value       = aws_db_instance.this.endpoint
}

output "db_instance_id" {
  description = "ID de la instancia RDS"
  value       = aws_db_instance.this.id
}
