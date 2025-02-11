resource "aws_lb_listener_rule" "this" {
  listener_arn = var.listener_arn
  priority     = var.priority

  dynamic "action" {
    for_each = var.actions
    content {
      type             = action.value.type
      target_group_arn = action.value.target_group_arn
      # Aquí puedes agregar más acciones según sea necesario
      # Puedes agregar otros tipos de acción como "fixed-response" o "redirect"
      # Ejemplo:
      # fixed_response {
      #   status_code = action.value.fixed_response.status_code
      #   content_type = action.value.fixed_response.content_type
      #   message_body = action.value.fixed_response.message_body
      # }
    }
  }

  dynamic "condition" {
    for_each = var.conditions
    content {
      # Condiciones genéricas: `host_header`, `path_pattern`, `query_string`, etc.
      dynamic "host_header" {
        for_each = contains(keys(condition.value), "host_header") ? [1] : []
        content {
          values = condition.value.host_header
        }
      }

      dynamic "path_pattern" {
        for_each = contains(keys(condition.value), "path_pattern") ? [1] : []
        content {
          values = condition.value.path_pattern
        }
      }

      dynamic "query_string" {
        for_each = contains(keys(condition.value), "query_string") ? [1] : []
        content {
          values = condition.value.query_string
        }
      }
    }
  }
}
