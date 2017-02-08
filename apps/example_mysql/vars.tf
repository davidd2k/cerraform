
variable "circonus-account-name" {
  description = "The name of the Circonus Account"
}

variable "circonus_api_url" {
  default = "https://api.circonus.com/v2"
}

variable "circonus_api_token" {
}


/*
variable "slack-channel" { }

variable "slack-escalate-channel" { }

variable "slack-team-id" { }

*/

variable "dbuser" {
  default = "root"
}

variable "dbpassword" {
  default = "root"
}

variable "dbhost" {
  default = "172.16.0.220"
}

variable "dbport" {
  default = "3306"
}
