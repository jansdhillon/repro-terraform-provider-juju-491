resource "juju_model" "lbaas" {
  name = var.lbaas_model_name
}

resource "juju_application" "haproxy" {
  model_uuid = juju_model.lbaas.id
  name  = "haproxy"

  charm {
    name    = "haproxy"
    channel = "2.8/edge"
  }

  config = {
    external-hostname = "repro.local"
    enable-hsts       = "false"
  }

  units = 1
}

resource "juju_application" "self_signed_certificates" {
  model_uuid = juju_model.lbaas.id
  name  = "self-signed-certificates"

  charm {
    name    = "self-signed-certificates"
    channel = "1/stable"
  }

  units = 1
}

resource "juju_integration" "haproxy_certs" {
  model_uuid = juju_model.lbaas.id

  application {
    name     = juju_application.haproxy.name
    endpoint = "certificates"
  }

  application {
    name     = juju_application.self_signed_certificates.name
    endpoint = "certificates"
  }
}

resource "juju_integration" "haproxy_receive_ca_certs" {
  model_uuid = juju_model.lbaas.id

  application {
    name     = juju_application.haproxy.name
    endpoint = "receive-ca-certs"
  }

  application {
    name     = juju_application.self_signed_certificates.name
    endpoint = "send-ca-cert"
  }
}

resource "juju_offer" "haproxy_route" {
  model_uuid       = juju_model.lbaas.id
  application_name = juju_application.haproxy.name
  endpoints        = ["haproxy-route"]
}
