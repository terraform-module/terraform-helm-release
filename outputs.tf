output "deployment" {
  value       = helm_release.this[0].metadata
  description = "The state of the helm deployment"
}
