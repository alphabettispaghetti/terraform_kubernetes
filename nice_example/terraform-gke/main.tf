#####################################################################
# Variables
#####################################################################
variable "username" {
  default = "admin"
}
variable "password" {
  default = "password"#"${random_string.password.result}"
}
variable "project" {}
variable "region" {
  default = "europe-west2"
}
variable "zone" {
  default = "${var.region}-b"
}

# resource "random_string" "password" {
#   length = 16
#   special = true
#   override_special = "/@\" "
# }

#####################################################################
# Modules
#####################################################################
module "gke" {
  source   = "./gke"
  project  = "${var.project}"
  region   = "${var.region}"
  username = "${var.username}"
  password = "${var.password}"
  zone     = "${var.zone}"

  
}

module "k8s" {
  source   = "./k8s"
  host     = "${module.gke.host}"
  username = "${var.username}"
  password = "${var.password}"

  client_certificate     = "${module.gke.client_certificate}"
  client_key             = "${module.gke.client_key}"
  cluster_ca_certificate = "${module.gke.cluster_ca_certificate}"
}
