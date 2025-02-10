output "policy_id" {
  description = "El ID de la política de IAM creada."
  value       = aws_iam_policy.this.id
}

output "policy_arn" {
  description = "El ARN de la política de IAM creada."
  value       = aws_iam_policy.this.arn
}

output "role_id" {
  description = "El ID del rol de IAM creado."
  value       = aws_iam_role.this.id
}

output "role_arn" {
  description = "El ARN del rol de IAM creado."
  value       = aws_iam_role.this.arn
}



