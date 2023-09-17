variable "cloudflare_api_token" {
  description = "Cloudflare api token variable for initial bootstrap, sourced from environment"
  sensitive   = true
  default     = ""
}