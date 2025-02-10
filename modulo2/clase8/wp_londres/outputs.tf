output "instance_public_ip" {
  description = "IP pública de la instancia de WordPress"
  value       = aws_instance.wordpress.public_ip
}

output "instance_id" {
  description = "ID de la instancia de WordPress"
  value       = aws_instance.wordpress.id
}
