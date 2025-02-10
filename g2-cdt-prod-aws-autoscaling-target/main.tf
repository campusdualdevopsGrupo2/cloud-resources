resource "aws_appautoscaling_target" "this" {
  service_namespace  = var.service_namespace
  resource_id        = var.resource_id
  scalable_dimension = var.scalable_dimension
  min_capacity       = var.min_capacity
  max_capacity       = var.max_capacity

  # El role_arn es opcional y puede ser requerido según el servicio.
  role_arn           = var.role_arn
}
