variable "mysql_tags" {
  type = "list"
  default = [
    "app:mysql",
    "author:terraform",
    "resource:database",
  ]
}

resource "circonus_check" "mysql" {
  collector {
    id = "${var.collectors_enterprise[0]}"
  }

  name       = "MySQL GLOBAL STATUS"
  notes      = <<EOF
This check shows results from the mysql SHOW GLOBAL STATUS command
EOF

  target = "${var.dbhost}"

  period = "30s"

  mysql {
    dsn = "${var.dsn}"
    query = <<EOF
  SHOW GLOBAL STATUS;
EOF
}
  stream {
    name = "${circonus_metric.threads_running.name}"
    tags = ["${circonus_metric.threads_running.tags}"]
    type = "${circonus_metric.threads_running.type}"
    unit = "${circonus_metric.threads_running.unit}"
  }

  stream {
    name = "${circonus_metric.bytes_sent.name}"
    tags = ["${circonus_metric.bytes_sent.tags}"]
    type = "${circonus_metric.bytes_sent.type}"
    unit = "${circonus_metric.bytes_sent.unit}"
  }

  tags = [ "${var.mysql_tags}" ]
}

resource "circonus_metric" "bytes_sent" {
  name = "Bytes_sent`Value"
  type = "numeric"
  unit = "null"
  tags = [ "${var.mysql_tags}" ]
}

resource "circonus_metric" "threads_running" {
  name = "Threads_running`Value"
  type = "numeric"
  unit = "null"
  tags = [ "${var.mysql_tags}" ]
}
