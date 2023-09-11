variable "api_url" {
  description = "This is the target Proxmox API endpoint."
  type        = string
  default     = "https://<proxmox_host_ip>:8006/api2/json"
}

variable "api_token_id" {
  description = "This is an API token you have previously created for a specific user."
  type        = string
  sensitive   = true
}

variable "api_token_secret" {
  description = "This uuid is only available when the token was initially created."
  type        = string
  sensitive   = true
}

variable "template_name" {
  description = "The template name to clone this vm from."
  type        = string
  default     = "cloudinit-template"
}
