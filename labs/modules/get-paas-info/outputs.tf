/*
output "Compartments" {
  value = "${data.oci_identity_compartments.compartments.compartments }"
}
*/


output "jcs_instance" {
  value = "${lookup(data.oci_core_instances.jcs_instances.instances[0], "id")}"
}

/*
output "vnic_attachments" {
  value = "${data.oci_core_vnic_attachments.jcs_vnic_attachments.vnic_attachments}"
}
*/

output "jcs_public_ip" {
       value = "${data.oci_core_vnic.jcs_vnic.0.is_primary ? trimspace(data.oci_core_vnic.jcs_vnic.0.public_ip_address) : trimspace(data.oci_core_vnic.jcs_vnic.1.public_ip_address) } "
}

output "jcs_private_ip" {
       value = "${data.oci_core_vnic.jcs_vnic.0.is_primary ? data.oci_core_vnic.jcs_vnic.0.private_ip_address : data.oci_core_vnic.jcs_vnic.1.private_ip_address } "
}


output "soa_instance" {
  value = "${lookup(data.oci_core_instances.soa_instances.instances[0], "id")}"
}


output "soa_public_ip" {
       value = "${data.oci_core_vnic.soa_vnic.0.is_primary ? trimspace(data.oci_core_vnic.soa_vnic.0.public_ip_address) : trimspace(data.oci_core_vnic.soa_vnic.1.public_ip_address) } "
}

output "soa_private_ip" {
       value = "${data.oci_core_vnic.soa_vnic.0.is_primary ? trimspace(data.oci_core_vnic.soa_vnic.0.private_ip_address) : trimspace(data.oci_core_vnic.soa_vnic.1.private_ip_address) } "
}


