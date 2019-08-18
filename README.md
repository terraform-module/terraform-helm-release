# Helm Release Module

## Usage example

Here's the gist of using it via github.

```terraform
module tiller {
  source     = "github.com/terraform-module/terraform-helm-release?ref=v2.0.0"
  namespace  = "app-namespace"
  repository = "https://kubernetes-charts.storage.googleapis.com"
  app = {
    "name"          = "jenkins"
    "version"       = "1.5.0"
    "chart"         = "stable/jenkins"
    "force_update"  = "true"
    "wait"          = "false"
    "recreate_pods" = "false"
    "deploy"        = 1
  }
  values = [templatefile("jenkins.yml", {
    region                = var.region
    storage               = "4Gi"
  })]

  set_strings = [
    {
      name  = "labels.kubernetes\\.io/name"
      value = "jenkins"
    },
    {
      name  = "service.labels.kubernetes\\.io/name"
      value = "jenkins"
    },
  ]
}
```

## Module Variables

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| app | an application to deploy | object | n/a | yes |
| namespace | namespace where to deploy an application | string | n/a | yes |
| repository | Helm repository | string | n/a | yes |
| set\_strings | Value block with custom STRING values to be merged with the values yaml. | object | n/a | yes |
| values | Extra values | list(string) | n/a | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Commands

<!-- START makefile-doc -->
```
$ make help 
hooks                          Commit hooks setup
validate                       Validate with pre-commit hooks
changelog                      Update changelog
release                        Create release version 
```
<!-- END makefile-doc -->

## How to Contribute

Submit a pull request

## Validate creation of components

```sh
kubectl get serviceaccount <name> -o yaml
kubectl get clusterrolebinding <name> -o yaml
kubectl get deploy <name> -o yaml
```
