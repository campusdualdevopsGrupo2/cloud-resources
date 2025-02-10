output "filename" {
  description = "Ruta del archivo creado"
  value       = local_file.this.filename
}

output "content" {
  description = "Contenido del archivo creado"
  value       = local_file.this.content
}
