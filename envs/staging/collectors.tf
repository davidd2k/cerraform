data "circonus_collector" "ashburn" {
  id = "/broker/1"
}

data "circonus_collector" "chicago" {
  id = "/broker/275"
}

data "circonus_collector" "httptrap" {
  id = "/broker/35"
}

// Circonus Enterprise Brokers
data "circonus_collector" "noit01" {
  id = "/broker/1886"
}

data "circonus_collector" "noit02" {
  id = "/broker/1895"
}
