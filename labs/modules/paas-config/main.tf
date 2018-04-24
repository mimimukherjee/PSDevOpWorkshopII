resource "null_resource" "soa-manager" {
  provisioner "local-exec" {
    command = "echo '{\"publicKeyText\":\"${join(" ",slice(split(" ",file("${var.ssh_public_key_path}")),0,2))}\", \"commonPwd\":\"${var.db_password}\", \"sRegion\":\"${var.region}\", \"availabilityDomain\":\"${var.soacs_ad}\", \"backupStorageContainer\":\"https://swiftobjectstorage.${var.region}.oraclecloud.com/v1/${var.tenancy}/${var.buckets[2]}\", \"dbBackupStorageContainer\":\"https://swiftobjectstorage.${var.region}.oraclecloud.com/v1/${var.tenancy}/${var.buckets[3]}\", \"backupStorageUser\":\"${var.object_storage_user}\", \"backupStoragePassword\": \"${var.swift_password}\", \"subnet\":\"${var.soacs_subnet}\", \"dbComputeShape\":\"${var.SOADBShape}\", \"wlComputeShape\":\"${var.SOAShape}\", \"wlComputeShape2\":\"${var.OTDShape}\"}' > soa.json"
  }
}


resource "null_resource" "jcs-manager" {
  provisioner "local-exec" {
    command = "echo '{\"publicKeyText\":\"${join(" ",slice(split(" ",file("${var.ssh_public_key_path}")),0,2))}\", \"commonPwd\":\"${var.db_password}\", \"sRegion\":\"${var.region}\", \"availabilityDomain\":\"${var.jcs_ad}\", \"backupStorageContainer\":\"https://swiftobjectstorage.${var.region}.oraclecloud.com/v1/${var.tenancy}/${var.buckets[0]}\", \"dbBackupStorageContainer\":\"https://swiftobjectstorage.${var.region}.oraclecloud.com/v1/${var.tenancy}/${var.buckets[1]}\", \"backupStorageUser\":\"${var.object_storage_user}\", \"backupStoragePassword\": \"${var.swift_password}\", \"subnet\":\"${var.jcs_subnet}\", \"dbComputeShape\":\"${var.DBShape}\", \"wlComputeShape\":\"${var.JCSShape}\"}' > jcs.json"
  }
}

resource "null_resource" "stack-manager-jcs" {
  depends_on = ["null_resource.jcs-manager"]

  provisioner "local-exec" {
    command = "python ${path.module}/stackmanager.py create jcs -u ${var.user} -p ${var.password} --debug -dn ${var.domain}  -pa ${path.module} -e ${var.env_prefix}"
  }

  provisioner "local-exec" {
    when = "destroy"
    command = "python ${path.module}/stackmanager.py delete jcs -u ${var.user} -p ${var.password} --debug -dn ${var.domain}  -pa ${path.module} -e ${var.env_prefix}"
  }
}

resource "null_resource" "stack-manager-soa" {
  depends_on = ["null_resource.soa-manager"]

  provisioner "local-exec" {
    command = "python ${path.module}/stackmanager.py create soa -u ${var.user} -p ${var.password} --debug -dn ${var.domain} -pa ${path.module} -e ${var.env_prefix}"
  }

  provisioner "local-exec" {
    when = "destroy"
    command = "python ${path.module}/stackmanager.py delete soa -u ${var.user} -p ${var.password} --debug -dn ${var.domain} -pa ${path.module} -e ${var.env_prefix}"
  }
}

