output "deployment" {
  value       = var.app["deploy"] ? [ helm_release.this[0].metadata ] : []
  description = "The state of the helm deployment"
}
