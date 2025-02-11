resource "kubernetes_horizontal_pod_autoscaler" "this" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels    = var.labels
  }

  spec {
    scale_target_ref {
      api_version = var.scale_target_api_version
      kind        = var.scale_target_kind
      name        = var.scale_target_name
    }

    min_replicas = var.min_replicas
    max_replicas = var.max_replicas

    # Definir métricas de forma dinámica
    dynamic "metric" {
      for_each = var.metrics
      content {
        type = metric.value.type

        dynamic "resource" {
          for_each = metric.value.type == "Resource" ? [metric.value.resource] : []
          content {
            name = resource.value.name
            target {
              type                = resource.value.target_type
              average_utilization = resource.value.average_utilization
            }
          }

        }
      }
    }
  }
}
