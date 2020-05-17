# Helm Release Module

[![](https://img.shields.io/github/license/terraform-module/terraform-helm-release)](https://github.com/terraform-module/terraform-helm-release)
![](https://img.shields.io/github/v/tag/terraform-module/terraform-helm-release)
[![](https://img.shields.io/github/workflow/status/terraform-module/terraform-helm-release/validate /master)](https://github.com/terraform-module/terraform-helm-release/actions?query=is%3Acompleted)
![](https://github.com/terraform-module/terraform-helm-release/workflows/Validator/badge.svg)
![](https://img.shields.io/issues/github/terraform-module/terraform-helm-release)
![](https://img.shields.io/github/issues/terraform-module/terraform-helm-release)
![](https://img.shields.io/github/issues-closed/terraform-module/terraform-helm-release)
[![](https://img.shields.io/github/languages/code-size/terraform-module/terraform-helm-release)](https://github.com/terraform-module/terraform-helm-release)
[![](https://img.shields.io/github/repo-size/terraform-module/terraform-helm-release)](https://github.com/terraform-module/terraform-helm-release)
![](https://img.shields.io/github/languages/top/terraform-module/terraform-helm-release?color=green&logo=terraform&logoColor=blue)
![](https://img.shields.io/github/commit-activity/m/terraform-module/terraform-helm-release)
![](https://img.shields.io/github/contributors/terraform-module/terraform-helm-release)
![](https://img.shields.io/github/last-commit/terraform-module/terraform-helm-release)

## Usage example

Here's the gist of using it via github.

```terraform
data helm_repository stable {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}

module jenkins {
  source  = "terraform-module/release/helm"
  version = "2.6.0"

  namespace  = "app-namespace"
  repository =  data.helm_repository.stable.metadata[0].name

  app = {
    name          = "jenkins"
    version       = "1.5.0"
    chart         = "jenkins"
    force_update  = true
    wait          = false
    recreate_pods = false
    deploy        = 1
  }
  values = [templatefile("jenkins.yml", {
    region                = var.region
    storage               = "4Gi"
  })]

  set = [
    {
      name  = "labels.kubernetes\\.io/name"
      value = "jenkins"
    },
    {
      name  = "service.labels.kubernetes\\.io/name"
      value = "jenkins"
    },
  ]

  set_sensitive = [
    {
      path  = "master.adminUser"
      value = "jenkins"
    },
  ]
}
```

## Module Variables

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| helm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app | an application to deploy | `map` | n/a | yes |
| namespace | namespace where to deploy an application | `any` | n/a | yes |
| repository | Helm repository | `string` | n/a | yes |
| set | Value block with custom STRING values to be merged with the values yaml. | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | n/a | yes |
| set\_sensitive | Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff. | <pre>list(object({<br>    path  = string<br>    value = string<br>  }))</pre> | `null` | no |
| values | Extra values | `list(string)` | n/a | yes |

## Outputs

No output.

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
