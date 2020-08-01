resource helm_release this {
  count         = var.app["deploy"] == true ? 1 : 0
  namespace     = var.namespace
  repository    = var.repository
  name          = var.app["name"]
  version       = var.app["version"]
  chart         = var.app["chart"]
  force_update  = lookup(var.app, "force_update", true)
  wait          = lookup(var.app, "wait", true)
  recreate_pods = lookup(var.app, "recreate_pods", true)
  max_history   = lookup(var.app, "max_history", 0)
  lint          = lookup(var.app, "lint", true)
  values        = var.values

  dynamic "set" {
    iterator = item
    for_each = var.set == null ? [] : var.set

    content {
      name  = item.value.name
      value = item.value.value
    }
  }

  dynamic "set_sensitive" {
    iterator = item
    for_each = var.set_sensitive == null ? [] : var.set_sensitive

    content {
      name  = item.value.path
      value = item.value.value
    }
  }
}
