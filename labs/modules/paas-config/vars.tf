variable "tenancy_ocid" {}
variable "buckets" {
  type = "list"
}
variable "ssh_public_key_path" {}
variable "swift_password" {}
variable "region" {}
variable "jcs_subnet" {}
variable "soacs_subnet" {}

variable "user" {}
variable "password" {}
variable "domain" {}
variable "tenancy" {}
variable "object_storage_user" {}

variable "DBShape" {}
variable "JCSShape" {}
variable "jcs_ad" {}

variable "SOAShape" {}
variable "SOADBShape" {}
variable "OTDShape" {}
variable "soacs_ad" {}

variable "db_password" {}
variable "env_prefix" {
  default = ""
}

