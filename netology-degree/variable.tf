variable "token" {
  type        = string
  description = "token id's"
  sensitive   = true
}

variable "cloud-id" {
  type        = string
  description = "Cloud id's"
  sensitive   = true
}

variable "folder-id" {
  type        = string
  description = "Folder id's"
  sensitive   = true
}

variable "user" {
  type        = string
  description = "ssh_username"
}

variable "ssh_key" {
  description = "ssh-pub"
}

variable "ssh_key_private" {
  description = "ssh-private"
  sensitive   = true
}

variable "service_account_id" {
  description = "account_id_from__instance_group"
  sensitive   = true
}

variable "data" {
  description = "metadata"
}


