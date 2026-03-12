# Repro: terraform-provider-juju issue #491

Reproduces https://github.com/juju/terraform-provider-juju/issues/491

## Prerequisites

- Juju >= 3.6.12
- Terraform >= 1.6.6
- A Juju controller bootstrapped (LXD or equivalent)

## Steps to reproduce

```bash
juju bootstrap lxd lxd-controller   # skip if you already have a controller, just provide it as the `controller_name` variable
terraform init
terraform apply -auto-approve
```

...

```
Error: Provider produced inconsistent result after apply

.application: planned set element
cty.ObjectVal({"offer_url": cty.StringVal("lxd-controller:admin/lbaas.haproxy")})
does not correlate with any element in actual.
```

## Variables

| Variable | Default | Description |
|---|---|---|
| `controller_name` | `lxd-controller` | Controller name prepended to the offer URL |
| `lbaas_model_name` | `lbaas` | Model created for haproxy + offer |
| `consumer_model_name` | `consumer` | Model created for the consumer app |
| `consumer_app_name` | `http-ingress` | App in the consumer model |
