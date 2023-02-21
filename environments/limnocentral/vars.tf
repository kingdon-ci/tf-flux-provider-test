variable "username" {
  type = string
  description = "Username for git repository."
  default = "kingdon-ci"
}

variable "private_key_pem_path" {
  type = string
  description = "Read/write deploy key for the git repository."
  default = "id_ed25519"
}
