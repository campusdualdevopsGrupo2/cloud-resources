data "template_file" "nginx_deployment_service_yaml" {
  template = file("${path.module}/chat-app-service.tpl")

}


resource "kubernetes_manifest" "nginx_deployment_service" {#el locad balancer en eks crea un lb de tipo network
  manifest = yamldecode(data.template_file.nginx_deployment_service_yaml.rendered)
  depends_on=[kubernetes_manifest.nginx_deployment]
}

data "external" "get_dns" {
  # En caso de usar Python, usa este comando:
   program = ["python3", "get_dns.py", "chat-app-service"]
   depends_on=[kubernetes_manifest.nginx_deployment_service]
}

resource "null_resource" "update_kubeconfig" {
  #depends_on = [module.eks]  # Asegura que este recurso se ejecute después de que el clúster EKS se haya creado.

  provisioner "local-exec" {
    command = "aws eks --region ${var.aws_region} update-kubeconfig --name ${var.cluster_name}"

    environment = {
      AWS_PROFILE = "default" # Si utilizas un perfil específico de AWS
    }
  }

  triggers = {
    always_run = "${timestamp()}" # Puedes añadir más parámetros aquí si lo necesitas
  }
}



