# Terraform module to Helm install Argocd

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_vault"></a> [vault](#provider\_vault) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.argocd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [random_password.argocd_admin_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [vault_generic_secret.vault_output](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/generic_secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_argocd_hostname"></a> [argocd\_hostname](#input\_argocd\_hostname) | Hostname for Argocd UI | `any` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of EKS cluster | `any` | n/a | yes |
| <a name="input_argo_global_image_tag"></a> [argo\_global\_image\_tag](#input\_argo\_global\_image\_tag) | Argocd global image tag | `string` | `"v2.0.1-arm"` | no |
| <a name="input_argocd_admin_groups"></a> [argocd\_admin\_groups](#input\_argocd\_admin\_groups) | Github groups for Argocd UI | `list` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_argocd_admin_users"></a> [argocd\_admin\_users](#input\_argocd\_admin\_users) | Github groups for Argocd UI | `list` | `[]` | no |
| <a name="input_argocd_version"></a> [argocd\_version](#input\_argocd\_version) | Argocd Helm version | `string` | `"3.2.4"` | no |
| <a name="input_cluster_bootstrap_repo"></a> [cluster\_bootstrap\_repo](#input\_cluster\_bootstrap\_repo) | Repo where the cluster bootstrap manifests reside | `string` | `""` | no |
| <a name="input_dex_image_tag"></a> [dex\_image\_tag](#input\_dex\_image\_tag) | Argocd global image tag | `string` | `"v2.28.1-arm"` | no |
| <a name="input_enable_argo_sso"></a> [enable\_argo\_sso](#input\_enable\_argo\_sso) | Optional flag to enable Argo Workflows SSO via Argocd dex auth | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment | `string` | `"test"` | no |
| <a name="input_github_oauth_clientID"></a> [github\_oauth\_clientID](#input\_github\_oauth\_clientID) | Github Oauth Client Id for SSO | `string` | `""` | no |
| <a name="input_github_oauth_clientSecret"></a> [github\_oauth\_clientSecret](#input\_github\_oauth\_clientSecret) | Github Oauth Client Secret for SSO | `string` | `""` | no |
| <a name="input_github_token"></a> [github\_token](#input\_github\_token) | Github token for Argocd access | `string` | `""` | no |
| <a name="input_github_username"></a> [github\_username](#input\_github\_username) | Github username for Argocd access | `string` | `""` | no |
| <a name="input_repo_server_max_replicas"></a> [repo\_server\_max\_replicas](#input\_repo\_server\_max\_replicas) | Maximum replicas for the repo server | `string` | `"5"` | no |
| <a name="input_repo_server_min_replicas"></a> [repo\_server\_min\_replicas](#input\_repo\_server\_min\_replicas) | Minimum replicas for the repo server | `string` | `"1"` | no |
| <a name="input_target_revision"></a> [target\_revision](#input\_target\_revision) | Revision to use for the cluster bootstrap repo | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_argo_sso_static_client_id"></a> [argo\_sso\_static\_client\_id](#output\_argo\_sso\_static\_client\_id) | Optional client id for Argo Workflows SSO, used to create dependency between argocd module and argo module |
| <a name="output_argocd_info"></a> [argocd\_info](#output\_argocd\_info) | n/a |
