output "policy_name" {
  description = "Nombre de la política de escalado"
  value       = aws_appautoscaling_policy.this.name
}

output "policy_arn" {
  description = "ARN de la política de escalado"
  value       = aws_appautoscaling_policy.this.arn
}

output "policy_type" {
  description = "Tipo de política de escalado (TargetTracking o StepScaling)"
  value       = aws_appautoscaling_policy.this.policy_type
}

output "scalable_dimension" {
  description = "Dimensión escalable del recurso (por ejemplo, ecs:service:DesiredCount)"
  value       = aws_appautoscaling_policy.this.scalable_dimension
}

output "target_value" {
  description = "Valor objetivo de la política de TargetTracking (si aplica)"
  value       = aws_appautoscaling_policy.this.target_tracking_scaling_policy_configuration[0].target_value
  sensitive   = true
}

output "predefined_metric_type" {
  description = "Tipo de métrica predefinida de la política de TargetTracking (si aplica)"
  value       = aws_appautoscaling_policy.this.target_tracking_scaling_policy_configuration[0].predefined_metric_specification[0].predefined_metric_type
}

output "scale_in_cooldown" {
  description = "Tiempo de enfriamiento después de un ajuste de escalado hacia abajo (si aplica)"
  value       = aws_appautoscaling_policy.this.target_tracking_scaling_policy_configuration[0].scale_in_cooldown
}

output "scale_out_cooldown" {
  description = "Tiempo de enfriamiento después de un ajuste de escalado hacia arriba (si aplica)"
  value       = aws_appautoscaling_policy.this.target_tracking_scaling_policy_configuration[0].scale_out_cooldown
}

output "adjustment_type" {
  description = "Tipo de ajuste de la política StepScaling (si aplica)"
  value       = aws_appautoscaling_policy.this.step_scaling_policy_configuration[0].adjustment_type
}

output "scaling_adjustment" {
  description = "Ajuste de escalado para StepScaling (si aplica)"
  value       = aws_appautoscaling_policy.this.step_scaling_policy_configuration[0].steps[0].scaling_adjustment
}

output "cooldown" {
  description = "Tiempo de enfriamiento para StepScaling (si aplica)"
  value       = aws_appautoscaling_policy.this.step_scaling_policy_configuration[0].cooldown
}
