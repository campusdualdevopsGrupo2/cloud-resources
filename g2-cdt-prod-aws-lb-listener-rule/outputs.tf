output "listener_rule_arn" {
  description = "ARN de la regla del Listener creada"
  value       = aws_lb_listener_rule.this.arn
}
