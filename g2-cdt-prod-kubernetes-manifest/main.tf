terraform {
  required_version = ">= 1.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.11.0"
    }
  }
}

# Define the Kubernetes provider for context1 with a static alias.
provider "kubernetes" {
  config_path    = var.kubeconfig_path
  config_context = var.kubeconfig_context
}

# Use a data block to load and template your manifest file.
data "template_file" "generic_manifest" {
  template = file(var.manifest_yaml)  # The manifest file (e.g., manifest.yaml)
  vars = {
    name = var.manifest_name         # This variable can be substituted inside the YAML file.
  }
}

# Create a Kubernetes manifest resource using the templated YAML.
resource "kubernetes_manifest" "generic_deployment" {
  manifest = yamldecode(data.template_file.generic_manifest.rendered)

  # Reference the statically defined provider alias.
  provider = kubernetes
}