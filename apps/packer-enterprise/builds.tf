variable "build_tags" {
  type = "list"
  default = [ "app:packer", "author:terraform", "source:postgresql" ]
}

resource "circonus_metric" "pending" {
  name = "pending`num"
  tags = [ "${var.build_tags}" ]
  type = "numeric"
}

resource "circonus_metric" "queued" {
  name = "queued`num"
  tags = [ "${var.build_tags}" ]
  type = "numeric"
}

resource "circonus_metric" "started" {
  name = "started`num"
  tags = [ "${var.build_tags}" ]
  type = "numeric"
}

resource "circonus_check" "builds" {
  collector {
    id = "${var.collectors[0]}"
  }

  name       = "${var.check_name}"
  notes      = "${var.check_notes}"

  postgresql {
    dsn = "${var.dsn}"
    query = <<EOF
SELECT
        d.status AS state, COALESCE(p.num, 0) AS num
FROM (
        SELECT
                unnest AS status
        FROM
                unnest(ARRAY['pending','queued', 'started'])) AS d
LEFT JOIN (
        SELECT
                status, COUNT(*) AS num
        FROM
                ops_builds p
        WHERE
                p.status IN ('pending', 'queued', 'started')
        GROUP BY p.status
) AS p ON d.status = p.status
EOF
  }

  stream {
    name = "${circonus_metric.pending.name}"
    tags = ["${circonus_metric.pending.tags}"]
    type = "${circonus_metric.pending.type}"
  }

  stream {
    name = "${circonus_metric.queued.name}"
    tags = ["${circonus_metric.queued.tags}"]
    type = "${circonus_metric.queued.type}"
  }

  stream {
    name = "${circonus_metric.started.name}"
    tags = ["${circonus_metric.started.tags}"]
    type = "${circonus_metric.started.type}"
  }

  tags = [ "${var.build_tags}" ]

  target = "${var.pghost}"
}
