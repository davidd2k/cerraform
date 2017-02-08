variable "atlas-worker-tags" {
  type = "list"
  default = [ "app:atlas", "app:atlas-worker", "source:nomad" ]
}

variable "circonus_account_name" {
  type = "string"
}

variable "environment" {
  type = "string"
}
