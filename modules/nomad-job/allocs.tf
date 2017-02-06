resource "circonus_stream_group" "cpu-kern" {
  name = "${var.human_name} CPU Kernel"
  description = "${var.cpu-kernel-description}"

  group {
    # This is an obsolete query due from when
    # `${var.job_name}-${var.task_group}` was the name of the metric.
    query = "*`${var.job_name}-${var.task_group}`cpu`system"
    type = "average"
  }

  group {
    # In a Waffles world, and until we have multiple jobs specs in a single .job
    # file again, this is the new and preferred query syntax.  Each job
    # submitted by Waffles creates a unique Job name that includes the git sha
    # of the job.
    query = "*`allocs`${var.job_name}-*`${var.task_group}`*`${var.task_group}`cpu`system"
    type = "average"
  }

  tags = [ "${var.nomad-tags}", "${var.job_tags}", "resource:cpu", "use:utilization" ]
  # unit = "%"
}

resource "circonus_stream_group" "cpu-throttled-periods" {
  name = "${var.human_name} CPU Throttled Periods"
  description = "${var.cpu-throttled-periods-description}"

  group {
    # This is an obsolete query due from when
    # `${var.job_name}-${var.task_group}` was the name of the metric.
    query = "*`${var.job_name}-${var.task_group}`cpu`throttled_periods"
    type = "average"
  }

  group {
    # In a Waffles world, and until we have multiple jobs specs in a single .job
    # file again, this is the new and preferred query syntax.  Each job
    # submitted by Waffles creates a unique Job name that includes the git sha
    # of the job.
    query = "*`allocs`${var.job_name}-*`${var.task_group}`*`${var.task_group}`cpu`throttled_periods"
    type = "average"
  }

  tags = [ "${var.nomad-tags}", "${var.job_tags}", "resource:cpu", "use:saturation" ]
}

resource "circonus_stream_group" "cpu-throttled-time" {
  name = "${var.human_name} CPU Throttled Time"
  description = "${var.cpu-throttled-time-description}"

  group {
    # This is an obsolete query due from when
    # `${var.job_name}-${var.task_group}` was the name of the metric.
    query = "*`${var.job_name}-${var.task_group}`cpu`throttled_time"
    type = "average"
  }

  group {
    # In a Waffles world, and until we have multiple jobs specs in a single .job
    # file again, this is the new and preferred query syntax.  Each job
    # submitted by Waffles creates a unique Job name that includes the git sha
    # of the job.
    query = "*`allocs`${var.job_name}-*`${var.task_group}`*`${var.task_group}`cpu`throttled_time"
    type = "average"
  }

  tags = [ "${var.nomad-tags}", "${var.job_tags}", "resource:cpu", "use:saturation" ]
  # unit = "nanoseconds"
}

resource "circonus_stream_group" "cpu-total-percent" {
  name = "${var.human_name} CPU Total Percentage"
  description = "${var.cpu-total-percentage-description}"

  group {
    # This is an obsolete query due from when
    # `${var.job_name}-${var.task_group}` was the name of the metric.
    query = "*`${var.job_name}-${var.task_group}`cpu`total_percent"
    type = "average"
  }

  group {
    # In a Waffles world, and until we have multiple jobs specs in a single .job
    # file again, this is the new and preferred query syntax.  Each job
    # submitted by Waffles creates a unique Job name that includes the git sha
    # of the job.
    query = "*`allocs`${var.job_name}-*`${var.task_group}`*`${var.task_group}`cpu`total_percent"
    type = "average"
  }

  tags = [ "${var.nomad-tags}", "${var.job_tags}", "resource:cpu", "use:utilization" ]
  # unit = "%"
}

resource "circonus_stream_group" "cpu-total-ticks" {
  name = "${var.human_name} CPU Total Ticks"
  description = "${var.cpu-total-ticks-description}"

  group {
    # This is an obsolete query due from when
    # `${var.job_name}-${var.task_group}` was the name of the metric.
    query = "*`${var.job_name}-${var.task_group}`cpu`total_ticks"
    type = "average"
  }

  group {
    # In a Waffles world, and until we have multiple jobs specs in a single .job
    # file again, this is the new and preferred query syntax.  Each job
    # submitted by Waffles creates a unique Job name that includes the git sha
    # of the job.
    query = "*`allocs`${var.job_name}-*`${var.task_group}`*`${var.task_group}`cpu`total_ticks"
    type = "average"
  }

  tags = [ "${var.nomad-tags}", "${var.job_tags}", "resource:cpu", "use:utilization" ]
  # unit = "ticks"
}

resource "circonus_stream_group" "cpu-user" {
  name = "${var.human_name} CPU Userland"
  description = "${var.cpu-user-description}"

  group {
    # This is an obsolete query due from when
    # `${var.job_name}-${var.task_group}` was the name of the metric.
    query = "*`${var.job_name}-${var.task_group}`cpu`user"
    type = "average"
  }

  group {
    # In a Waffles world, and until we have multiple jobs specs in a single .job
    # file again, this is the new and preferred query syntax.  Each job
    # submitted by Waffles creates a unique Job name that includes the git sha
    # of the job.
    query = "*`allocs`${var.job_name}-*`${var.task_group}`*`${var.task_group}`cpu`user"
    type = "average"
  }

  tags = [ "${var.nomad-tags}", "${var.job_tags}", "resource:cpu", "use:utilization" ]
  # unit = "ticks"
}

resource "circonus_graph" "cpu" {
  name = "CPU for job ${var.job_name}-${var.task_group}"
  description = "The amount of CPU time, both kernel and userland, that task grou ${var.task_group} has consumed in the job ${var.human_name} (${var.job_name})."

  stream_group {
    group = "${circonus_stream_group.cpu-user.id}"
    aggregate = "sum"
    axis = "left"
    # color = "#657aa6"
    name = "Userland CPU"
  }

  stream_group {
    group = "${circonus_stream_group.cpu-kern.id}"
    aggregate = "sum"
    axis = "left"
    # color = "#7e17d8"
    name = "Kernel CPU"
  }

  tags = [ "${var.nomad-tags}", "${var.job_tags}", "resource:cpu", "use:utilization" ]
}

# https://${var.circonus-account-name}.circonus.com/checks/clusters?id=${circonus_stream_group.memory-rss.cluster_id}
resource "circonus_stream_group" "memory-cache" {
  name = "${var.human_name} Memory Cache"
  description = "${var.memory-cache-description}"

  group {
    # This is a mostly obsolete query from when
    # ${var.job_name}-${var.task_group} was the name of the metric.
    query = "*`${var.job_name}-${var.task_group}`memory`cache"
    type = "average"
  }

  group {
    # In a Waffles world, and until we can have multiple job specs with the same
    # job name, this is the new and preferred query syntax to catch the fact
    # that we have a dynamic job name.
    query = "*`allocs`${var.job_name}-*`${var.task_group}`*`${var.task_group}`memory`cache"
    type = "average"
  }

  tags = [ "${var.nomad-tags}", "${var.job_tags}", "resource:memory", "use:utilization" ]
  # unit = "bytes"
}

resource "circonus_stream_group" "memory-kernel-max-usage" {
  name = "${var.human_name} Memory Kernel Max Usage"
  description = "${var.memory-kernel-max-usage-description}"

  group {
    # This is a mostly obsolete query from when
    # ${var.job_name}-${var.task_group} was the name of the metric.
    query = "*`${var.job_name}-${var.task_group}`memory`kernel_max_usage"
    type = "average"
  }

  group {
    # In a Waffles world, and until we can have multiple job specs with the same
    # job name, this is the new and preferred query syntax to catch the fact
    # that we have a dynamic job name.
    query = "*`allocs`${var.job_name}-*`${var.task_group}`*`${var.task_group}`memory`kernel_max_usage"
    type = "average"
  }

  tags = [ "${var.nomad-tags}", "${var.job_tags}", "resource:memory", "use:utilization" ]
}

resource "circonus_stream_group" "memory-kernel-usage" {
  name = "${var.human_name} Memory Kernel Usage"
  description = "${var.memory-kernel-usage-description}"

  group {
    # This is a mostly obsolete query from when
    # ${var.job_name}-${var.task_group} was the name of the metric.
    query = "*`${var.job_name}-${var.task_group}`memory`kernel_usage"
    type = "average"
  }

  group {
    # In a Waffles world, and until we can have multiple job specs with the same
    # job name, this is the new and preferred query syntax to catch the fact
    # that we have a dynamic job name.
    query = "*`allocs`${var.job_name}-*`${var.task_group}`*`${var.task_group}`memory`kernel_usage"
    type = "average"
  }

  tags = [ "${var.nomad-tags}", "${var.job_tags}", "resource:memory", "use:utilization" ]
  # unit = "bytes"
}

# https://${var.circonus-account-name}.circonus.com/checks/clusters?id=${circonus_stream_group.memory-rss.cluster_id}
resource "circonus_stream_group" "memory-max-usage" {
  name = "${var.human_name} Memory Max Usage"
  description = "${var.memory-max-usage-description}"

  group {
    # This is a mostly obsolete query from when
    # ${var.job_name}-${var.task_group} was the name of the metric.
    query = "*`${var.job_name}-${var.task_group}`memory`max_usage"
    type = "average"
  }

  group {
    # In a Waffles world, and until we can have multiple job specs with the same
    # job name, this is the new and preferred query syntax to catch the fact
    # that we have a dynamic job name.
    query = "*`allocs`${var.job_name}-*`${var.task_group}`*`${var.task_group}`memory`max_usage"
    type = "average"
  }

  tags = [ "${var.nomad-tags}", "${var.job_tags}", "resource:memory", "use:utilization" ]
  # unit = "bytes"
}

# https://${var.circonus-account-name}.circonus.com/checks/clusters?id=${circonus_stream_group.memory-rss.cluster_id}
resource "circonus_stream_group" "memory-swap" {
  name = "${var.human_name} Memory Swap"
  description = "${var.memory-swap-description}"

  group {
    # This is a mostly obsolete query from when
    # ${var.job_name}-${var.task_group} was the name of the metric.
    query = "*`${var.job_name}-${var.task_group}`memory`swap"
    type = "average"
  }

  group {
    # In a Waffles world, and until we can have multiple job specs with the same
    # job name, this is the new and preferred query syntax to catch the fact
    # that we have a dynamic job name.
    query = "*`allocs`${var.job_name}-*`${var.task_group}`*`${var.task_group}`memory`swap"
    type = "average"
  }

  tags = [ "${var.nomad-tags}", "${var.job_tags}", "resource:memory", "use:saturation" ]
  # unit = "bytes"
}

# https://${var.circonus-account-name}.circonus.com/checks/clusters?id=${circonus_stream_group.memory-rss.cluster_id}
resource "circonus_stream_group" "memory-rss" {
  name = "${var.human_name} Memory RSS"
  description = "${var.memory-rss-description}"

  group {
    # This is a mostly obsolete query from when
    # ${var.job_name}-${var.task_group} was the name of the metric.
    query = "*`${var.job_name}-${var.task_group}`memory`rss"
    type = "average"
  }

  group {
    # In a Waffles world, and until we can have multiple job specs with the same
    # job name, this is the new and preferred query syntax to catch the fact
    # that we have a dynamic job name.
    query = "*`allocs`${var.job_name}-*`${var.task_group}`*`${var.task_group}`memory`rss"
    type = "average"
  }

  tags = [ "${var.nomad-tags}", "${var.job_tags}", "resource:memory", "use:utilization" ]
}
