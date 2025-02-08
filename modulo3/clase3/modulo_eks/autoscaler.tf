resource "kubernetes_horizontal_pod_autoscaler" "nginx_autoscaler" {
  metadata {
    name = "nginx-hpa"
  }

  spec {
    max_replicas = 10
    min_replicas = 2
    target_cpu_utilization_percentage = 80

    scale_target_ref {
      api_version = "autoscaling/v2"
      kind        = "Deployment"
      name        = kubernetes_deployment.nginx.metadata[0].name
    }
  }
}
