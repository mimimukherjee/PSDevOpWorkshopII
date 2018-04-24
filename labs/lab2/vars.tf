############################# User Configuration ####################################

variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "ssh_public_key" {}
variable "ssh_public_key_path" {}
variable "ssh_authorized_private_key" {}
variable "compartment_ocid" {}
variable "paas_compartment_ocid" {}

variable "subscription_id" {}
variable "user" {}
variable "password" {}
variable "domain" {}
variable "tenancy" {}
variable "object_storage_user" {}

variable "swift_password" {}

variable "env_prefix" {
  default = "lab2"
}

############################### Compute Configuration #################################

variable "compute_name" {
  default="DevOps-Instance"
}
variable "compute_label" {
  default="devops-instance"
}
variable "instance_shape" {
  default="VM.Standard2.1"
}
variable "image_ocid" {
  default="ocid1.image.oc1.iad.aaaaaaaaafmyat7i5s7ae3aylwtvmt7v4dw4yy2thgzaqlbjzoxngrjg54xq"
}


variable "config_src_dir" {
  default="/app"
}

variable "DBShape" {
  default="VM.Standard1.2"
}
variable "JCSShape" {
  default="VM.Standard2.1"
}
variable "SOAShape" {
  default="VM.Standard1.2"
}
variable "SOADBShape" {
  default="VM.Standard2.1"
}
variable "OTDShape" {
  default="VM.Standard1.1"
}

############################ VCN Configuration #######################################

variable "dns_vcn" {
  default="tfvcn"
}
variable "oraclevcn" {
  default="oraclevcn.com"
}
variable "vcn_display" {
  default="DevOpsVCN"
}

############################ Object Storage and Swift Password ##############################

variable "swift_password_description" {
  default="Ojbect Storage password for PaaS"
}
variable "bucket_names" {
  default = ["jcs_backup", "jcs_dbcs_backup", "soacs_backup", "soacs_dbcs_backup" ]
}

############################## Database Configuration ####################################

variable "DataStorgePercent" {
  default="40"
}
variable "DBNodeShape" {
    default = "VM.Standard1.2"
}
variable "CPUCoreCount" {
    default = "2"
}
variable "DBEdition" {
    default = "ENTERPRISE_EDITION"
}
variable "DBAdminPassword" {
    default = "STateinsurance12#_"
}

# OracleDB SID 
variable "DBName" {
    default = "TFdb"
}
variable "DBVersion" {
    default = "12.1.0.2"
}
variable "DBDisplayName" {
    default = "TFDB"
}
variable "DBDiskRedundancy" {
    default = "HIGH"
}
variable "DBNodeDisplayName" {
    default = "TFDB"
}
variable "DBNodeHostName" {
    default = "OracleDB"
}
variable "HostUserName" {
    default = "opc"
}
variable "NCharacterSet" {
  default = "AL16UTF16"
}
variable "CharacterSet" {
  default = "AL32UTF8"
}
variable "DBWorkload" {
  default = "OLTP"
}
variable "PDBName" {
  default = "pdbName"
}
variable "DataStorageSizeInGB" {
  default = "256"
}
variable "LicenseModel" {
  default = "LICENSE_INCLUDED"
}
variable "NodeCount" {
  default = "1"
}
