resource "null_resource" "config-scripts" {

  provisioner "file" {
    connection {
      host = "${var.public-ip}" 
      user = "ubuntu"
      private_key = "${var.ssh_private_key}"
    }
    source      = "${path.module}/scripts/"
    destination = "/tmp/"
  }
}

resource "null_resource" "config-installer" {

  provisioner "file" {
   connection {
     host = "${var.public-ip}" 
     user = "ubuntu"
     private_key = "${var.ssh_private_key}"
   }
   source      = "${var.config_src_dir}/installer/"
   destination = "/tmp/"
 }
}

resource "null_resource" "weblogic-config" {

  depends_on = ["null_resource.config-installer", "null_resource.config-scripts"]
  
  provisioner "remote-exec" {
    connection {
      host= "${var.public-ip}"
      user = "ubuntu"
      private_key = "${var.ssh_private_key}"
    }
    
    inline = [
      "chmod +x /tmp/install_weblogic.sh",	
      "sudo /tmp/install_weblogic.sh"
    ]
  }
}

/*
resource "null_resource" "app-config" {

  depends_on = ["null_resource.weblogic-config"]
  
  provisioner "remote-exec" {
    connection {
      host= "${var.public-ip}"
      user = "ubuntu"
      private_key = "${var.ssh_private_key}"
    }

    inline = [
      "sleep 1m",		
      "sudo docker exec -it -u root wlsadmin wlst /u01/oracle/deploy_app.py"
    ]
  }
}
*/
