resource "kubernetes_service" "this" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels    = var.labels
  }

  spec {
    selector = var.selector
    type     = var.service_type

    port {
      name        = var.port_name
      port        = var.port
      target_port = var.target_port
      protocol    = var.port_protocol
    }
  }
}
