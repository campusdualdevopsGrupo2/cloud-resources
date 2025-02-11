/*output "policy_id" {
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
}*/

# Salida para el rol de IAM creado
output "iam_role_name" {
  description = "El nombre del rol IAM creado"
  value       = aws_iam_role.this.name
}

# Salida para el ARN del rol de IAM creado
output "iam_role_arn" {
  description = "El ARN del rol IAM creado"
  value       = aws_iam_role.this.arn
}

# Salida para la política de IAM creada
output "iam_policy_name" {
  description = "El nombre de la política IAM creada"
  value       = aws_iam_policy.this.name
}

# Salida para el ARN de la política de IAM creada
output "iam_policy_arn" {
  description = "El ARN de la política IAM creada"
  value       = aws_iam_policy.this.arn
}

# Salida para los ARNs de las políticas adjuntas al rol IAM
output "attached_policy_arns" {
  description = "Lista de los ARNs de las políticas adjuntas al rol"
  value       = [for attachment in aws_iam_role_policy_attachment.this : attachment.policy_arn]
}


