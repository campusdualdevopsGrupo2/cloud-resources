# Proveedor de Kubernetes
provider "kubernetes" {
  config_path = "${env.HOME}/.kube/config"
}

provider "aws" {
  region = var.provider_region
}