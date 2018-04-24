resource "null_resource" "get-paas-info" {
  provisioner "local-exec" {
    command = "echo getting paas instance info ... "
  }
}


