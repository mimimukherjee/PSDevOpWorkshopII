resource "null_resource" "db-config" {
  provisioner "file" {
    connection {
      host= "${data.oci_core_vnic.DBNodeVnic.public_ip_address}"
      user = "opc"
      private_key = "${var.ssh_private_key}"
    }
    source = "${path.module}/scripts/"
    destination = "/tmp"
  }

  provisioner "remote-exec" {
    connection {
      host= "${data.oci_core_vnic.DBNodeVnic.public_ip_address}"
      user = "opc"
      private_key = "${var.ssh_private_key}"
    }
    
    inline = [
      "chmod 777 /tmp/db_config.sh",	
      "chmod 666 /tmp/StateInsurance.sql",	
      "sudo su - oracle -c \"/tmp/db_config.sh ${var.DBNodeHostName} ${var.DBNodeDomainName} ${var.DBName} ${var.PDBName} \""
    ]
  }
}
