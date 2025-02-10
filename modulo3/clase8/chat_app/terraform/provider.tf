provider "aws" {
  region = var.aws_region
}
provider "kubernetes" {
  config_path = "~/.kube/config"
}