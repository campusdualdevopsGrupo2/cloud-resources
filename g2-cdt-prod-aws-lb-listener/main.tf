resource "aws_lb_listener" "this" {
  load_balancer_arn = var.load_balancer_arn
  port              = var.port
  protocol          = var.protocol

  /*# Configuración SSL opcional solo si el protocolo es HTTPS
  dynamic "ssl_configuration" {
    for_each = var.protocol == "HTTPS" ? [1] : []
    content {
      ssl_policy      = var.ssl_policy
      certificate_arn = var.certificate_arn
    }
  }*/

  dynamic "default_action" {
    for_each = var.default_actions
    content {
      type             = default_action.value.type
      target_group_arn = default_action.value.target_group_arn

      # Puedes añadir más configuraciones de acción si es necesario
      # Por ejemplo, para acciones de tipo `fixed-response`
      dynamic "fixed_response" {
        for_each = default_action.value.type == "fixed-response" ? [1] : []
        content {
          status_code = default_action.value.fixed_response.status_code
          content_type = default_action.value.fixed_response.content_type
          message_body = default_action.value.fixed_response.message_body
        }
      }

      # Redirección como otro tipo de acción
      dynamic "redirect" {
        for_each = default_action.value.type == "redirect" ? [1] : []
        content {
          status_code = default_action.value.redirect.status_code
          host        = default_action.value.redirect.host
          path        = default_action.value.redirect.path
          query       = default_action.value.redirect.query
          port        = default_action.value.redirect.port
          protocol    = default_action.value.redirect.protocol
        }
      }
    }
  }
}
