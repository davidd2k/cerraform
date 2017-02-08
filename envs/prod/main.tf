module "circonus" {
  source = "../modules/circonus"

  account_name = "${var.circonus-account-name}"
  alert_slack_channel_name = "${var.slack-channel}"
  alert_slack_escalate_channel_name = "${var.slack-escalate-channel}"
  alert_slack_team_id = "${var.slack-team-id}"
  api_token  = "${var.circonus_api_token}"
  collectors_enterprise = ["${data.circonus_collector.noit01.id}"]
  collectors_public = ["${data.circonus_collector.ashburn.id}", "${data.circonus_collector.chicago.id}"]
  check_name = "Circonus SaaS Check"
  environment = "prod"
}

module "packer_queues" {
  source = "../modules/packer-enterprise"

  collectors = ["${data.circonus_collector.noit01.id}"]
  check_name = "Packer Queue Times"
  check_notes = "Check to observe various queue times in PostgreSQL"
  dsn = "user=${var.dbuser} host=${var.dbhost} port=${var.dbport} host=${var.dbhost} password=${var.dbpassword}"
  pghost = "${var.dbhost}"
}

module "consul-cluster" {
  source = "../modules/consul-cluster"
}

module "consul-server1" {
  source = "../modules/consul-server"

  collector_id = "${data.circonus_collector.httptrap.id}"
  hostname = "consul-server-10-181-1-8"
  secret = "f4140a1f39943180"
}

module "consul-server2" {
  source = "../modules/consul-server"

  collector_id = "${data.circonus_collector.httptrap.id}"
  hostname = "consul-server-10-181-2-8"
  secret = "d94352cc66aaefa2"
}

module "consul-server3" {
  source = "../modules/consul-server"

  collector_id = "${data.circonus_collector.httptrap.id}"
  hostname = "consul-server-10-181-3-8"
  secret = "17a8d8cdea65e31a"
}
