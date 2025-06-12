# Helm Release Module

[![](https://img.shields.io/github/license/terraform-module/terraform-helm-release)](https://github.com/terraform-module/terraform-helm-release)
![](https://img.shields.io/github/v/tag/terraform-module/terraform-helm-release)
[![](https://img.shields.io/github/workflow/status/terraform-module/terraform-helm-release/commit-check/master)](https://github.com/terraform-module/terraform-helm-release/actions?query=is%3Acommit-check)
![](https://github.com/terraform-module/terraform-helm-release/workflows/commit-check/badge.svg)
![](https://img.shields.io/issues/github/terraform-module/terraform-helm-release)
![](https://img.shields.io/github/issues/terraform-module/terraform-helm-release)
![](https://img.shields.io/github/issues-closed/terraform-module/terraform-helm-release)
[![](https://img.shields.io/github/languages/code-size/terraform-module/terraform-helm-release)](https://github.com/terraform-module/terraform-helm-release)
[![](https://img.shields.io/github/repo-size/terraform-module/terraform-helm-release)](https://github.com/terraform-module/terraform-helm-release)
![](https://img.shields.io/github/languages/top/terraform-module/terraform-helm-release?color=green&logo=terraform&logoColor=blue)
![](https://img.shields.io/github/commit-activity/m/terraform-module/terraform-helm-release)
![](https://img.shields.io/github/contributors/terraform-module/terraform-helm-release)
![](https://img.shields.io/github/last-commit/terraform-module/terraform-helm-release)

## Table Of Contents

- [Helm Release Module](#helm-release-module)
  * [Usage example](#usage-example)
  * [Module Variables](#module-variables)
  * [Requirements](#requirements)
  * [Providers](#providers)
  * [Inputs](#inputs)
  * [Outputs](#outputs)
  * [Commands](#commands)
  * [Validate creation of components](#validate-creation-of-components)
    + [:memo: Guidelines](#-memo--guidelines)
  * [License](#license)
  * [How to Contribute](#how-to-contribute)
- [Authors](#authors)
  * [Terraform Registry](#terraform-registry)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>

## Usage example

Here's the gist of using it via github.

```terraform
module jenkins {
  source  = "terraform-module/release/helm"
  version = "2.6.0"

  namespace  = "app-namespace"
  repository =  "https://charts.helm.sh/stable"

  app = {
    name          = "jenkins"
    description   = "some custom description"
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
| terraform | >= 0.13 |
| helm | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| helm | >= 2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app | an application to deploy | `map(any)` | n/a | yes |
| namespace | namespace where to deploy an application | `string` | n/a | yes |
| repository | Helm repository | `string` | n/a | yes |
| repository\_config | repository configuration | `map(any)` | n/a | yes |
| set | Value block with custom STRING values to be merged with the values yaml. | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `null` | no |
| set\_sensitive | Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff. | <pre>list(object({<br>    path  = string<br>    value = string<br>  }))</pre> | `null` | no |
| values | Extra values | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| deployment | The state of the helm deployment |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Commands

<!-- START makefile-doc -->
```
$ make help
hooks                          Commit hooks setup
validate                       Validate with pre-commit hooks
changelog                      Update changelog
```
<!-- END makefile-doc -->

## Validate creation of components

```sh
kubectl get serviceaccount <name> -o yaml
kubectl get clusterrolebinding <name> -o yaml
kubectl get deploy <name> -o yaml
```

### :memo: Guidelines

 - :memo: Use a succinct title and description.
 - :bug: Bugs & feature requests can be be opened
 - :signal_strength: Support questions are better asked on [Stack Overflow](https://stackoverflow.com/)
 - :blush: Be nice, civil and polite ([as always](http://contributor-covenant.org/version/1/4/)).

## License

Copyright 2019 Ivan Katliarhcuk

MIT Licensed. See [LICENSE](./LICENSE) for full details.

## How to Contribute

Submit a pull request

# Authors

Currently maintained by [Ivan Katliarchuk](https://github.com/ivankatliarchuk) and these [awesome contributors](https://github.com/terraform-module/terraform-module-blueprint/graphs/contributors).

[![ForTheBadge uses-git](http://ForTheBadge.com/images/badges/uses-git.svg)](https://GitHub.com/)

## Terraform Registry

- [Module](https://registry.terraform.io/modules/terraform-module/release/helm)
