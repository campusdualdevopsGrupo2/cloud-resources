output "scaling_policy_arn" {
  description = "ARN de la política de autoescalado creada"
  value       = aws_appautoscaling_policy.this.arn
}
