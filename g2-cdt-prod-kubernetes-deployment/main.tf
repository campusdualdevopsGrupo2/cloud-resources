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
        dynamic "container" {
          for_each = var.containers
          content {
            name  = container.value.name
            image = container.value.image

            dynamic "port" {
              for_each = container.value.ports
              content {
                container_port = port.value
              }
            }

            # Si deseas agregar variables dinámicas de recursos, puedes hacerlo aquí
            dynamic "resources" {
              for_each = container.value.resources != null ? [container.value.resources] : []
              content {
                requests {
                  cpu    = resources.value.requests.cpu
                  memory = resources.value.requests.memory
                }
                limits {
                  cpu    = resources.value.limits.cpu
                  memory = resources.value.limits.memory
                }
              }
            }
          }
        }

        dynamic "volume" {
          for_each = var.volumes != null ? var.volumes : []
          content {
            name = volume.value.name

            persistent_volume_claim {
              claim_name = volume.value.claim_name
            }
          }
        }
      }
    }
  }
}
