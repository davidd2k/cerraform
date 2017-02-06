module "atlas-worker-job" {
  source = "../nomad-job"
  environment = "${var.environment}"
  human_name = "Atlas Worker"
  job_name = "atlas"
  task_group = "worker"
  job_tags = [ "app:atlas", "app:atlas-worker" ]
}
