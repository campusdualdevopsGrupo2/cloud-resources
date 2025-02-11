resource "kubernetes_service" "this" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels    = var.labels
  }

  spec {
    selector = var.selector
    type     = var.service_type

    # Hacer que los puertos sean dinámicos (por ejemplo, múltiples puertos)
    dynamic "port" {
      for_each = var.ports
      content {
        name        = port.value.name
        port        = port.value.port
        target_port = port.value.target_port
        protocol    = port.value.protocol
      }
    }

    # Condicional para manejar servicios tipo LoadBalancer con externalIPs
    dynamic "external_ips" {
      for_each = var.service_type == "LoadBalancer" && length(var.external_ips) > 0 ? var.external_ips : []
      content {
        ip = external_ips.value
      }
    }
  }
}
