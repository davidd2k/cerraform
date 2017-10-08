variable "dbhost" {

}

variable "dsn" {

}

variable "account_name" {
  description = "The name of the Circonus Account to use"
}

variable "api_token" {}

variable "collectors_enterprise" {
  type = "list"
}

variable "collectors_public" {
  type = "list"
}

variable "check_name" {}

variable "environment" {
  description = "Specify the environment (e.g. prod, staging, etc)"
  type = "string"
}

variable "check_notes" {
  default = "A check to collect telemetry regarding the metric usage of a Circonus account."
}

variable "target" {
  default = "api.circonus.com"
}
