output "offer_url_bare" {
  value       = module.lbaas.haproxy_route_offer_url
  description = "Bare offer URL as returned by juju_offer (admin/model.app)."
}

output "offer_url_controller_qualified" {
  value       = "${var.controller_name}:${module.lbaas.haproxy_route_offer_url}"
  description = "Controller-qualified offer URL used in the integration. This is what triggers the bug."
}
