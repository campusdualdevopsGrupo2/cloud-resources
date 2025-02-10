output "role_id" {
  description = "El ID del rol de IAM creado."
  value       = aws_iam_role.this.id
}

output "role_arn" {
  description = "El ARN del rol de IAM creado."
  value       = aws_iam_role.this.arn
}
