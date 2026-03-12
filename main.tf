module "lbaas" {
  source           = "./modules/lbaas"
  lbaas_model_name = var.lbaas_model_name
}

resource "juju_model" "consumer" {
  name = var.consumer_model_name
}

resource "juju_application" "http_ingress" {
  model_uuid = juju_model.consumer.id
  name       = var.consumer_app_name

  charm {
    name    = "ingress-configurator"
    channel = "latest/edge"
  }

  units = 1
}

resource "juju_integration" "http_ingress_haproxy_route" {
  model_uuid = juju_model.consumer.id
  application {
    offer_url = "${var.controller_name}:${module.lbaas.haproxy_route_offer_url}"
  }

  application {
    name     = var.consumer_app_name
    endpoint = "haproxy-route"
  }
}
