/* These can be overridden with the appropriate environment variable:
 - TF_VAR_circonus_account_name=vynjo as an example
*/
variable "circonus_account_name" {
  description = "The name of the Circonus Account"
}

variable "circonus_api_url" {
  default = "https://api.circonus.com/v2"
}

variable "circonus_api_token" {
}

variable "dbuser" {
  default = "root"
}

variable "dbpassword" {
  default = "root"
}

variable "dbhost" {
  default = "YOUR_DB_HOST_IP"
}

variable "dbport" {
  default = "3306"
}
