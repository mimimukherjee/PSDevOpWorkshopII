

module "get-paas-info" {
  source = "../modules/get-paas-info"
  paas_compartment_id = "${var.paas_compartment_ocid}"
  jcs_display_name = "${var.subscription_id}|JaaS|${var.env_prefix}JCSDBCSStackJCS|wls|vm-1"
  soa_display_name = "${var.subscription_id}|SOA|${var.env_prefix}SOAStackSOACS|wls|vm-1"
}


output "JCS Instance" {
  value = "${module.get-paas-info.jcs_instance}"
}

output "JCS Public IP" {
  value = "${module.get-paas-info.jcs_public_ip}"
}

output "SOA Instance" {
  value = "${module.get-paas-info.soa_instance}"
}

output "SOA Public IP" {
  value = "${module.get-paas-info.soa_public_ip}"
}


output "StateGov App Url" {
  value = "http://${trimspace(module.get-paas-info.jcs_public_ip)}/StateGov-WebService-context-root/"
}
