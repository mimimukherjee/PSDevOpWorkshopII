
variable "wlst" {}
variable "liberty_ip" {}
variable "osb_ip" {}
variable "jcs_ip" {}
variable "password" {}
variable "dbconn" {}
variable "targets" {}
variable "ssh_private_key" {}

variable "liberty_warfile" {
  default = "LibertyInsurance-WebServiceApp-context-root.war"
}
variable "sbconfig_jarfile" {
  default = "sbconfig.jar"
}
variable "state_warfile" {
  default = "StateGov-WebService-context-root.war"
}
