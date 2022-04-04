variable "environment" {
  description = "Environment"
  default     = "test"
}

variable "cluster_name" {
  description = "Name of EKS cluster"
}

variable "argocd_version" {
  description = "Argocd Helm version"
  default     = "3.2.4"
}

variable "argo_global_image_tag" {
  description = "Argocd global image tag"
  default     = "v2.0.1-arm"
}

variable "dex_image_tag" {
  description = "Argocd global image tag"
  default     = "v2.28.1-arm"
}

variable "argocd_hostname" {
  description = "Hostname for Argocd UI"
}

variable "argocd_admin_groups" {
  description = "Github groups for Argocd UI"
  default     = [""]
}

variable "enable_argo_sso" {
  description = "Optional flag to enable Argo Workflows SSO via Argocd dex auth"
  default     = false
}

variable "cluster_bootstrap_repo" {
  description = "Repo where the cluster bootstrap manifests reside"
  default     = ""
}

variable "target_revision" {
  description = "Revision to use for the cluster bootstrap repo"
  default     = "HEAD"
}

variable "repo_server_min_replicas" {
  description = "Minimum replicas for the repo server"
  default     = "1"
}

variable "repo_server_max_replicas" {
  description = "Maximum replicas for the repo server"
  default     = "5"
}

variable "github_oauth_clientID" {
  description = "Github Oauth Client Id for SSO"
  default     = ""
}

variable "github_oauth_clientSecret" {
  description = "Github Oauth Client Secret for SSO"
  default     = ""
}

variable "github_username" {
  description = "Github username for Argocd access"
  default     = ""
}

variable "github_token" {
  description = "Github token for Argocd access"
  default     = ""
}
