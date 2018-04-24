
resource "null_resource" "liberty-app-config" {
  
  provisioner "local-exec" {
    command = "${var.wlst} ${path.module}/deploy_liberty_app.py ${var.url} ${var.password} ${var.targets} ${var.warfile} "
  }
}

