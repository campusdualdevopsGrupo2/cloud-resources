output "security_group_id" {
  description = "El ID del grupo de seguridad creado."
  value       = aws_security_group.this.id
}

output "security_group_name" {
  description = "El nombre del grupo de seguridad creado."
  value       = aws_security_group.this.name
}
