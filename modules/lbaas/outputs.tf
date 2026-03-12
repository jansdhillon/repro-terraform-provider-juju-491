output "haproxy_route_offer_url" {
  value       = juju_offer.haproxy_route.url
  description = "Bare offer URL returned by Juju (e.g. admin/lbaas.haproxy)."
}
