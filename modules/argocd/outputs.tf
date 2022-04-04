output "argocd_info" {
  value = "\n\n\tArgocd will be available at the URL below in ~5min once apps and DNS are setup\n\n\thttp://${var.argocd_hostname}\n"
}

output "argo_sso_static_client_id" {
  description = "Optional client id for Argo Workflows SSO, used to create dependency between argocd module and argo module"
  value       = var.enable_argo_sso ? "${var.cluster_name}-argo-id" : ""
}

output "admin_password" {
  description = "Argocd admin password"
  sensitive   = true
  value       = random_password.argocd_admin_password.result
}
