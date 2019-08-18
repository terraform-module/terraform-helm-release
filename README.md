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

| Name                            | Description                                                   |     Type     |                  Default                  | Required |
| ------------------------------- | ------------------------------------------------------------- | :----------: | :---------------------------------------: | :------: |
| automount_service_account_token | Enable automatin mounting of the service account token        |     bool     |                 `"true"`                  |    no    |
| component                       | Component name                                                |    string    |                 `"helm"`                  |    no    |
| name                            | Generic name                                                  |    string    |                `"tiller"`                 |    no    |
| namespace                       | Namespace to where deploy tiller                              |    string    |                    n/a                    |   yes    |
| service_namespaces              | The ServiceAccounts to grant permissions to. Example ['helm'] | list(string) |                    n/a                    |   yes    |
| tiller_image                    | Tiller Docker image                                           |    string    | `"gcr.io/kubernetes-helm/tiller:v2.14.2"` |    no    |
| tiller_max_history              | Tiller history to contain                                     |    string    |                  `"200"`                  |    no    |
| tiller_replicas                 | Amound of replicas to deploy                                  |    string    |                   `"1"`                   |    no    |
| tiller_service_type             | Type of Tiller's Kubernetes service object.                   |    string    |               `"ClusterIP"`               |    no    |
| tiller_version                  | Tiller version                                                |    string    |                `"v2.14.2"`                |    no    |

## Outputs

| Name            | Description       |
| --------------- | ----------------- |
| service_account | a service account |

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
