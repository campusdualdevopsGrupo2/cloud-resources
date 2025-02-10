resource "kubernetes_deployment" "this" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels    = var.labels
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = var.match_labels
    }

    template {
      metadata {
        labels = var.template_labels
      }

      spec {
        container {
          name  = var.container_name
          image = var.image

          port {
            container_port = var.container_port
          }
        }
      }
    }
  }
}
