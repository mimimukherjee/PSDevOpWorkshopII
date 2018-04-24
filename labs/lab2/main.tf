
module "object_storage" {
  source = "../modules/storage-swift"
  bucket_names = "${var.bucket_names}"
  env_prefix = "${var.env_prefix}"
  compartment_id = "${var.compartment_ocid}"
}

module "vcn" {
  source = "../modules/vcn"
  tenancy_ocid = "${var.tenancy_ocid}"
  compartment_ocid = "${var.compartment_ocid}"
  dns_vcn = "${var.env_prefix}${var.dns_vcn}"
  vcn_display = "${var.env_prefix}${var.vcn_display}"
}

module "compute" {
  source = "../modules/compute-instance"
  tenancy_ocid = "${var.tenancy_ocid}"
  compartment_ocid = "${var.compartment_ocid}"
  ssh_public_key = "${var.ssh_public_key}"
  ssh_private_key = "${var.ssh_authorized_private_key}"
  instance_shape = "${var.instance_shape}"
  image_ocid = "${var.image_ocid}"
  subnet = "${module.vcn.subnet2_ocid}"
  name = "${var.env_prefix}${var.compute_name}"
  label = "${var.env_prefix}${var.compute_label}"
  availability_domain = "${module.vcn.subnet2_ad}"
}

module "database" {
  source = "../modules/database"
  tenancy_ocid = "${var.tenancy_ocid}"
  compartment_ocid = "${var.compartment_ocid}"
  availability_domain = "${module.vcn.subnet2_ad}"
  SubnetOCID = "${module.vcn.subnet2_ocid}"
  ssh_public_key = "${var.ssh_public_key}"
  DBNodeDomainName = "${module.vcn.subnet2_label}.${var.env_prefix}${var.dns_vcn}.${var.oraclevcn}"
  DataStorgePercent = "${var.DataStorgePercent}"
  DBNodeShape = "${var.DBNodeShape}"
  CPUCoreCount = "${var.CPUCoreCount}"
  DBEdition = "${var.DBEdition}"
  DBAdminPassword = "${var.DBAdminPassword}"
  DBName = "${var.DBName}"
  DBVersion = "${var.DBVersion}"
  DBDisplayName = "${var.DBDisplayName}"
  DBDiskRedundancy = "${var.DBDiskRedundancy}"
  DBNodeDisplayName = "${var.env_prefix}${var.DBNodeDisplayName}"
  DBNodeHostName = "${var.DBNodeHostName}"
  HostUserName = "${var.HostUserName}"
  NCharacterSet = "${var.NCharacterSet}"
  CharacterSet = "${var.CharacterSet}"
  DBWorkload = "${var.DBWorkload}"
  PDBName = "${var.PDBName}"
  DataStorageSizeInGB = "${var.DataStorageSizeInGB}"
  LicenseModel = "${var.LicenseModel}"
  NodeCount = "${var.NodeCount}"
  ssh_private_key = "${var.ssh_authorized_private_key}"
}

module "docker-config" {
  source = "../modules/docker-config"
  tenancy_ocid = "${var.tenancy_ocid}"
  compartment_ocid = "${var.compartment_ocid}"
  public-ip = "${module.compute.public-ip}"
  ssh_private_key = "${var.ssh_authorized_private_key}"
  config_src_dir = "${var.config_src_dir}"
}

module "paas" {
  source = "../modules/paas-config"
  user = "${var.user}"
  db_password = "${var.DBAdminPassword}"
  password = "${var.password}"
  domain = "${var.domain}"
  jcs_subnet = "${module.vcn.subnet3_ocid}"
  soacs_subnet = "${module.vcn.subnet3_ocid}"
  region = "${var.region}"
  tenancy_ocid = "${var.tenancy_ocid}"
  ssh_public_key_path = "${var.ssh_public_key_path}"
  object_storage_user = "${var.object_storage_user}"
  swift_password = "${var.swift_password}"
  OTDShape = "${var.OTDShape}"
  SOAShape = "${var.SOAShape}"
  SOADBShape = "${var.SOADBShape}"
  JCSShape = "${var.JCSShape}"
  DBShape = "${var.DBShape}"
  tenancy = "${var.tenancy}"
  buckets = "${module.object_storage.names}"
  jcs_ad = "${module.vcn.subnet3_ad}"
  soacs_ad = "${module.vcn.subnet3_ad}"
  env_prefix = "${var.env_prefix}"
}



output "Compute Public IP" {
  value = "${module.compute.public-ip}"
}

output "DB Public IP" {
  value = "${module.database.DBNodePublicIP}"
}			
