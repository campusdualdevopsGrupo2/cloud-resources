resource "aws_lb_listener_rule" "this" {
  listener_arn = var.listener_arn
  priority     = var.priority

  dynamic "action" {
    for_each = var.actions
    content {
      type = action.value.type

      dynamic "forward" {
        for_each = action.value.type == "forward" ? [action.value.forward] : []
        content {
          target_group {
            arn    = forward.value.target_group_arn
            weight = forward.value.weight
          }
          dynamic "stickiness" {
            for_each = forward.value.stickiness != null ? [forward.value.stickiness] : []
            content {
              enabled  = stickiness.value.enabled
              duration = stickiness.value.duration
            }
          }
        }
      }

      dynamic "redirect" {
        for_each = action.value.type == "redirect" ? [action.value.redirect] : []
        content {
          host        = redirect.value.host
          port        = redirect.value.port
          protocol    = redirect.value.protocol
          status_code = redirect.value.status_code
        }
      }

      dynamic "fixed_response" {
        for_each = action.value.type == "fixed-response" ? [action.value.fixed_response] : []
        content {
          content_type = fixed_response.value.content_type
          message_body = fixed_response.value.message_body
          status_code  = fixed_response.value.status_code
        }
      }

      dynamic "authenticate_cognito" {
        for_each = action.value.type == "authenticate-cognito" ? [action.value.authenticate_cognito] : []
        content {
          user_pool_arn       = authenticate_cognito.value.user_pool_arn
          user_pool_client_id = authenticate_cognito.value.user_pool_client_id
          user_pool_domain    = authenticate_cognito.value.user_pool_domain
        }
      }

      dynamic "authenticate_oidc" {
        for_each = action.value.type == "authenticate-oidc" ? [action.value.authenticate_oidc] : []
        content {
          authorization_endpoint = authenticate_oidc.value.authorization_endpoint
          client_id              = authenticate_oidc.value.client_id
          client_secret          = authenticate_oidc.value.client_secret
          issuer                 = authenticate_oidc.value.issuer
          token_endpoint         = authenticate_oidc.value.token_endpoint
          user_info_endpoint     = authenticate_oidc.value.user_info_endpoint
        }
      }
    }
  }

  dynamic "condition" {
    for_each = var.conditions
    content {
      dynamic "host_header" {
        for_each = lookup(condition.value, "host_header", null) != null ? [condition.value.host_header] : []
        content {
          values = condition.value.host_header
        }
      }

      dynamic "http_header" {
        for_each = lookup(condition.value, "http_header_name", null) != null ? [condition.value.http_header] : []
        content {
          http_header_name = condition.value.http_header_name
          values           = condition.value.http_header_values
        }
      }

      dynamic "path_pattern" {
        for_each = lookup(condition.value, "path_pattern", null) != null ? [condition.value.path_pattern] : []
        content {
          values = condition.value.path_pattern
        }
      }

      dynamic "query_string" {
        for_each = lookup(condition.value, "query_string_key", null) != null ? [condition.value.query_string] : []
        content {
          key   = condition.value.query_string_key
          value = condition.value.query_string_value
        }
      }

      dynamic "source_ip" {
        for_each = lookup(condition.value, "source_ip", null) != null ? [condition.value.source_ip] : []
        content {
          values = condition.value.source_ip
        }
      }

    }
  }

  tags = var.tags
}
