variable "controller_name" {
  type        = string
  default     = "lxd-controller"
  description = "Juju controller name prepended to the offer URL. This controller-qualified form (e.g. lxd-controller:admin/lbaas.haproxy) is what triggers the bug."
}

variable "lbaas_model_name" {
  type        = string
  default     = "lbaas"
  description = "Name of the model the lbaas module will create for haproxy."
}

variable "consumer_model_name" {
  type        = string
  default     = "consumer"
  description = "Name for the consumer model that Terraform will create."
}

variable "consumer_app_name" {
  type        = string
  default     = "http-ingress"
  description = "Application in the consumer model that has the haproxy-route endpoint."
}
