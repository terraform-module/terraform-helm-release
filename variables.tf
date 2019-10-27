variable "namespace" {
  description = "namespace where to deploy an application"
}

variable "app" {
  description = "an application to deploy"
  type = object({
    name          = string
    version       = string
    chart         = string
    force_update  = bool
    wait          = bool
    recreate_pods = bool
    deploy        = number
  })
}

variable "values" {
  description = "Extra values"
  type        = list(string)
}

variable "set_strings" {
  description = "Value block with custom STRING values to be merged with the values yaml."
  type = list(object({
    name  = string
    value = string
  }))
}

variable "set_sensitive" {
  description = "Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff."
  type = list(object({
    path  = string
    value = string
  }))
  default = null
}

variable "repository" {
  description = "Helm repository"
  type        = string
}