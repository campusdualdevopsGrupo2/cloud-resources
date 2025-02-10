data "template_file" "nginx_deployment_yaml" {
  template = file("${path.module}/chat-deploy.tpl")

  vars = {
    ecr_url = "${var.ecr_url}:chat-bot"
  }
}


resource "kubernetes_manifest" "nginx_deployment" {
  manifest = yamldecode(data.template_file.nginx_deployment_yaml.rendered)
}


