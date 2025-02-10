output "scalable_target_arn" {
  description = "ARN del target escalable registrado"
  value       = aws_appautoscaling_target.this.arn
}
