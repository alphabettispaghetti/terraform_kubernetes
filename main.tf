module "gke" {
  source           = "./modules/gke"
  username         = "${var.username}"
  password         = "${var.password}"
  cluster_name     = "${var.cluster_name}"
  node_pools       = "${var.node_pools}"

  global           = "${var.global}"
}

# module "k8s" {
#   source   = "./modules/k8s"
#   host     = "${module.gke.host}"
#   username = "${var.username}"
#   password = "${var.password}"
#
#   client_certificate     = "${module.gke.client_certificate}"
#   client_key             = "${module.gke.client_key}"
#   cluster_ca_certificate = "${module.gke.cluster_ca_certificate}"
# }
