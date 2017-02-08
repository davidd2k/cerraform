variable "aws_access_key_id" { }

variable "aws_secret_access_key" { }

variable "circonus-account-name" {
  description = "The name of the Circonus Account"
}

variable "circonus_api_url" {
  default = "https://api.circonus.com/v2"
}

variable "circonus_api_token" {
  # A default value is required for imports to succeed.
  #
  # default = ""
}

variable "dbuser" { }

variable "dbpassword" { }

variable "dbhost" { }

variable "dbport" {
  default = "5432"
}

variable "slack-channel" { }

variable "slack-escalate-channel" { }

variable "slack-team-id" { }
