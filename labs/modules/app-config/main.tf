# add build app here before config and deploy



resource "null_resource" "liberty-app-config" {

  provisioner "local-exec" {
    command = "${var.wlst} ${path.module}/config_deploy_liberty_app.py t3://${var.liberty_ip}:7001 welcome1 ${var.password} ${path.module}/${var.liberty_warfile} ${var.dbconn}  "
  }
}

resource "null_resource" "osb-proxy-config" { 
  depends_on = ["null_resource.liberty-app-config"]

  provisioner "remote-exec" {
    connection {
      host= "${var.osb_ip}"
      user = "opc"
      private_key = "${var.ssh_private_key}"
    }

    inline = [
      "sudo su -c \"echo ${var.liberty_ip}  LibertyWLS >> /etc/hosts \" "
    ]
  }

   
  provisioner "local-exec" {
    /***********************************************************************
      Note: this wlst must include required osb jar files in the classpath 
            such as the following:
            OSB_HOME="/u01/fmw/osb"
            CLASSPATH=${OSB_HOME}/lib/modules/oracle.servicebus.configfwk.jar:${OSB_HOME}/lib/modules/oracle.servicebus.kernel-api.jar:${OSB_HOME}/lib/modules/oracle.servicebus.configfwk-wls.jar:${OSB_HOME}/lib/modules/oracle.servicebus.kernel-wls.jar:${CLASSPATH}

    *************************************************************************/

    command = "${var.wlst} ${path.module}/import_sbconfig.py t3://${var.osb_ip}:9001 weblogic ${var.password} ${path.module}/${var.sbconfig_jarfile} "
  }
}

resource "null_resource" "state-app-config" {
  depends_on = ["null_resource.osb-proxy-config"]
 
  provisioner "remote-exec" {
    connection {
      host= "${var.jcs_ip}"
      user = "opc"
      private_key = "${var.ssh_private_key}"
    }

    inline = [
      "sudo su -c \"echo ${var.osb_ip}  soastacksoacs   >> /etc/hosts \""
    ]
  }
 
  provisioner "local-exec" {
    command = "${var.wlst} ${path.module}/deploy_state_app.py t3://${var.jcs_ip}:9001 ${var.password} ${var.targets} ${path.module}/${var.state_warfile} "  
  }
}

