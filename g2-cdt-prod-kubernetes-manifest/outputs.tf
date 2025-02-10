output "manifest_name" {
  description = "El nombre del recurso creado desde el manifiesto."
  value       = var.manifest_name
}

output "manifest_kind" {
  description = "El tipo de recurso Kubernetes especificado en el manifiesto (Deployment, Service, etc.)."
  value       = yamldecode(data.template_file.generic_manifest.rendered)["kind"]
}

output "manifest_namespace" {
  description = "El namespace donde se crea el recurso Kubernetes, si está definido en el manifiesto."
  value       = yamldecode(data.template_file.generic_manifest.rendered)["metadata"]["namespace"]
}

output "manifest_labels" {
  description = "Las etiquetas asociadas al recurso Kubernetes, si están definidas en el manifiesto."
  value       = yamldecode(data.template_file.generic_manifest.rendered)["metadata"]["labels"]
}

output "manifest_metadata" {
  description = "Metadatos generales del manifiesto Kubernetes (como nombre y namespace)."
  value       = yamldecode(data.template_file.generic_manifest.rendered)["metadata"]
}
