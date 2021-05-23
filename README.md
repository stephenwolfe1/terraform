# Terraform
Repo to manage homelab terraform services and modules.


## Table of contents

<!--ts-->

* [Table of contents](#table-of-contents)
* [Ordering](#ordering)
* [Usage](#usage)

<!--te-->

## Ordering
Current ordering is based on Vault install being managed in homelab repo. If this moves to Argocd bootstrap vault_config and argocd would swap. Argocd would need a bootstrap method for credentials.

* *_root-setup* Should be run first to create AWS resources for Terraform user and state storage. Requires manual IAM user credentials loaded from _~/.aws/_

* *kube_resources* Terraform managed secrets for kubernetes resources

* *vault_config* Setups vault configuration for auth, policies, mounts, ect.

* *argocd* Helm install for Argocd and adds a bootstrap application to configure all other Kubernetes services.


## Usage

```bash
Terraform repo:

        Usage: NAME=${service} make [target]

pull                           pull terraformer image
init                           run terraformer init
validate                       run terraformer validate
plan                           run terraformer plan
apply                          run terraformer apply
destroy                        run terraformer destroy
shell                          run terraformer shell
docs                           run terraform-docs
save-root                      manually save root-setup terraform.state
fetch-root                     manually fetch root-setup terraform.state
clean                          clean up terraform directories
help                           show this usage
```
