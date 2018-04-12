
/* You can specify an Enterprise Collector by using the following instead:
    id = "${var.collectors_enterprise[0]}"
*/

resource "circonus_check" "histogramtest" {
  name = "Test of All CPU Metrics into Histogram (Merged Histogram)"
  period = "60s"

  collector {
    id = "/broker/1490"
  }

  caql {
    query = <<EOF
search:metric("*cpu*(active:1)") | histogram:create()
EOF
  }

  metric {
    name = "output[1]"
    tags = [ "${var.test_tags}", "subsystem:test", "use:error" ]
    type = "histogram"
  }

  tags = [ "${var.test_tags}", "subsystem:test" ]
}

resource "circonus_graph" "histogramtest" {
  name = "Test of All CPU Metrics into Histogram (Merged Histogram)"
  description = "Test of All CPU Metrics into Histogram"
  line_style = "stepped"

  metric {
    check = "${circonus_check.histogramtest.checks[0]}"
    metric_name = "output[1]"
    metric_type = "histogram"
    axis = "left"
    color = "#657aa6"
    name = "Test of All CPU Metrics into Histogram"
  }
}
