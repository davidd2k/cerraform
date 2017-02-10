data "circonus_collector" "ashburn" {
  id = "/broker/1"
}

data "circonus_collector" "chicago" {
  id = "/broker/275"
}

data "circonus_collector" "httptrap" {
  id = "/broker/35"
}

/*
You can add your own Enterprise Collector as well. The ID is contained in the API object for the Collector - specifically the _cid field.

data "circonus_collector" "YOUR_BROKER_HERE" {
  id = "/broker/ID_FROM_API_OBJECT"
}
*/
