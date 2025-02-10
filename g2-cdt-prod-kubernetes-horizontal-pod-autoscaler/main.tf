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

    metric {
      type = var.metric_type

      resource {
        name = var.resource_name
        target {
          type                = var.target_type
          average_utilization = var.average_utilization
        }
      }
    }
  }
}
