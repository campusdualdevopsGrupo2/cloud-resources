data "template_file" "generic_manifest" {
  template = file(var.manifest_yaml)

  vars = {
    name = var.manifest_name
  }
}


resource "kubernetes_manifest" "generic_deployment" {
  manifest = yamldecode(data.template_file.generic_manifest.rendered)

  # Configura otros parámetros si es necesario, como el contexto del clúster
  provider = kubernetes.${var.kubernetes_context} # Asegúrate de tener un proveedor adecuado
}