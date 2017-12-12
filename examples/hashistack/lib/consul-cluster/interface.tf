variable "consul_tags" {
  type    = "list"
  default = ["creator:terraform", "app:consul", "app:consul-server", "source:consul"]
}
