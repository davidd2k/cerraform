/*variable "aws_access_key_id" { }

variable "aws_secret_access_key" { }*/

variable "circonus-account-name" {
  description = "The name of the Circonus Account"
  default = "vynjo"
}

variable "circonus_api_url" {
  default = "https://api.circonus.com/v2"
}

variable "circonus_api_token" {
  default ="9598206a-25fb-c279-f37d-d63a4b208fa2"
}

/*variable "dbuser" { }

variable "dbpassword" { }

variable "dbhost" { }

variable "dbport" {
  default = "5432"
}

variable "slack-channel" { }

variable "slack-escalate-channel" { }

variable "slack-team-id" { } */
