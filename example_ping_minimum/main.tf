module "circonus" {
  source = "modules/circonus"

  account_name = "${var.circonus-account-name}"
  /*alert_slack_channel_name = "${var.slack-channel}"
  alert_slack_escalate_channel_name = "${var.slack-escalate-channel}"
  alert_slack_team_id = "${var.slack-team-id}"*/
  api_token  = "${var.circonus_api_token}"
  /*
  collectors_enterprise = ["${data.circonus_collector.YOUR_BROKER_NAME_HERE.id}"]
  */
  collectors_public = ["${data.circonus_collector.ashburn.id}", "${data.circonus_collector.chicago.id}"]
  check_name = "Circonus SaaS Check"
  environment = "dev"
}
