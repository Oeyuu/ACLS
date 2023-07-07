variable "bootstrap_servers" {
  type = list(string)
}

variable "super_user_sasl_username" {
  type    = string
}

variable "super_user_sasl_password" {
  type    = string
}

variable "msk_cluster_name" {
  type = string
  default = "mskcluster"
}