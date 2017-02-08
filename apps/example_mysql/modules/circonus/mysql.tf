variable "mysql_tags" {
  type = "list"
  default = [
    "app:mysql",
    "author:terraform",
    "resource:database",
  ]
}

resource "circonus_check" "icmp_latency" {
  collector {
    id = "${var.collectors_enterprise[0]}"
  }

  name       = "ICMP Latency from Enterprise Collector"
  notes      = <<EOF
This check measures the network latency between Vynjo's Enterprise Collector(s) and
www.vynjo.com.
EOF

  icmp_ping {
    count = 1
  }

  target = "www.vynjo.com"

  period = "60s"

  stream {
    name = "${circonus_metric.icmp_latency.name}"
    tags = ["${circonus_metric.icmp_latency.tags}"]
    type = "${circonus_metric.icmp_latency.type}"
    unit = "${circonus_metric.icmp_latency.unit}"
  }

  tags = [ "${var.latency_tags}" ]
}
/*
Uncomment this section if you want to have a check to/from your Enterprise Broker
resource "circonus_check" "icmp_latency" {
  collector {
    id = "${var.collectors_enterprise[0]}"
  }

  name       = "ICMP Latency from Enterprise Collector"
  notes      = <<EOF
This check measures the network latency between ENTERPRISE_BROKER_NAME Enterprise Collector(s) and
www.vynjo.com.
EOF

  icmp_ping {
    count = 1
  }

  target = "www.vynjo.com"

  period = "60s"

  stream {
    name = "${circonus_metric.icmp_latency.name}"
    tags = ["${circonus_metric.icmp_latency.tags}"]
    type = "${circonus_metric.icmp_latency.type}"
    unit = "${circonus_metric.icmp_latency.unit}"
  }

  tags = [ "${var.latency_tags}" ]
}*/

resource "circonus_metric" "icmp_latency" {
  name = "minimum"
  type = "numeric"
  unit = "seconds"
  tags = [ "${var.latency_tags}" ]
}

resource "circonus_graph" "icmp_minimum" {
  name = "www.vynjo.com Ping Latency from Ashburn, VA Broker"
  description = "The minimum ping time between Vynjo's home broker and www.vynjo.com"
  line_style = "stepped"

  stream {
    check = "${circonus_check.icmp_latency.checks[0]}"
    stream_name = "minimum"
    metric_type = "numeric"
    axis = "left"
    color = "#17b6d6"
    name = "Ping Minimum Latency"
  }

  tags = [ "${var.latency_tags}" ]
}
