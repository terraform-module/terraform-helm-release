resource "helm_release" "this" {
  count                      = var.app["deploy"] ? 1 : 0
  namespace                  = var.namespace
  repository                 = var.repository
  repository_key_file        = lookup(var.repository_config, "repository_key_file", null)
  repository_cert_file       = lookup(var.repository_config, "repository_cert_file", null)
  repository_ca_file         = lookup(var.repository_config, "repository_ca_file", null)
  repository_username        = lookup(var.repository_config, "repository_username", null)
  repository_password        = lookup(var.repository_config, "repository_password", null)
  name                       = var.app["name"]
  version                    = var.app["version"]
  chart                      = var.app["chart"]
  force_update               = lookup(var.app, "force_update", false)
  description                = lookup(var.app, "description", null)
  wait                       = lookup(var.app, "wait", true)
  recreate_pods              = lookup(var.app, "recreate_pods", true)
  max_history                = lookup(var.app, "max_history", 0)
  lint                       = lookup(var.app, "lint", true)
  cleanup_on_fail            = lookup(var.app, "cleanup_on_fail", false)
  create_namespace           = lookup(var.app, "create_namespace", false)
  disable_webhooks           = lookup(var.app, "disable_webhooks", false)
  verify                     = lookup(var.app, "verify", false)
  reuse_values               = lookup(var.app, "reuse_values", false)
  reset_values               = lookup(var.app, "reset_values", false)
  atomic                     = lookup(var.app, "atomic", false)
  skip_crds                  = lookup(var.app, "skip_crds", false)
  render_subchart_notes      = lookup(var.app, "render_subchart_notes", true)
  disable_openapi_validation = lookup(var.app, "disable_openapi_validation", false)
  wait_for_jobs              = lookup(var.app, "wait_for_jobs", false)
  dependency_update          = lookup(var.app, "dependency_update", false)
  replace                    = lookup(var.app, "replace", false)
  timeout                    = lookup(var.app, "timeout", 300)
  upgrade_install            = lookup(var.app, "upgrade_install", false)
  values                     = var.values

  set = [for item in coalesce(var.set, []): { "name": item.name, "value": item.value}]
  set_sensitive = [for item in coalesce(var.set_sensitive, []): { "name": item.path, "value": item.value}]

}
