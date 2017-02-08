/*module "atlas" {
  source = "../modules/atlas"

  circonus_account_name = "${var.circonus-account-name}"
  environment = "staging"
}*/

module "circonus" {
  source = "../modules/circonus"

  account_name = "${var.circonus-account-name}"
  /*alert_slack_channel_name = "${var.slack-channel}"
  alert_slack_escalate_channel_name = "${var.slack-escalate-channel}"
  alert_slack_team_id = "${var.slack-team-id}"*/
  api_token  = "${var.circonus_api_token}"
  collectors_enterprise = ["${data.circonus_collector.home_broker.id}"]
  collectors_public = ["${data.circonus_collector.ashburn.id}", "${data.circonus_collector.chicago.id}"]
  check_name = "Circonus SaaS Check"
  environment = "staging"
}

/*module "consul-cluster" {
  source = "../modules/consul-cluster"
}

module "consul-server1" {
  source = "../modules/consul-server"

  collector_id = "${data.circonus_collector.httptrap.id}"
  hostname = "consul-server-10-151-1-8"
  secret = "57778aed918c2b8d"
}

module "consul-server2" {
  source = "../modules/consul-server"

  collector_id = "${data.circonus_collector.httptrap.id}"
  hostname = "consul-server-10-151-2-8"
  secret = "a1123631d2ec0ad8"
}

module "consul-server3" {
  source = "../modules/consul-server"

  collector_id = "${data.circonus_collector.httptrap.id}"
  hostname = "consul-server-10-151-3-8"
  secret = "33a09eb6ef2a5aca"
}*/

/*module "packer_queues" {
  source = "../modules/packer-enterprise"

  collectors = ["${data.circonus_collector.noit01.id}"]
  check_name = "Packer Queue Times"
  check_notes = "Check to observe various queue times in PostgreSQL"
  dsn = "user=${var.dbuser} host=${var.dbhost} port=${var.dbport} host=${var.dbhost} password=${var.dbpassword}"
  pghost = "${var.dbhost}"
}

module "postgresql_atlas" {
  source = "../modules/postgresql-atlas"

  aws_secret_access_key = "${var.aws_secret_access_key}"
  aws_access_key_id = "${var.aws_access_key_id}"
  collectors = ["${data.circonus_collector.ashburn.id}"]
  check_name = "PostgreSQL Health"
  check_notes = "Check to observe various queue times in PostgreSQL"
}*/
