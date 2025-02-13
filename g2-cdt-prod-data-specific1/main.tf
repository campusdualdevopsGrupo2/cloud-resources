data "external" "get_dns" {
  # En caso de usar Python, usa este comando:
   program = ["python3", "get_dns.py", "chat-app-service"]
   depends_on=[kubernetes_manifest.nginx_deployment_service]
}
