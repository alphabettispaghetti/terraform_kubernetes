resource "google_container_cluster" "primary" {
  name               = "${var.cluster_name}"
  location           = "${lookup(var.global, "location")}"

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. Consequently we create the smallest possible
  # default node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count = 1

  addons_config {
    network_policy_config {
      disabled = true
    }
  }
}

#####################################################################
# Output for K8S
#####################################################################
output "client_certificate" {
  value     = "${google_container_cluster.primary.master_auth.0.client_certificate}"
  sensitive = true
}

output "client_key" {
  value     = "${google_container_cluster.primary.master_auth.0.client_key}"
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = "${google_container_cluster.primary.master_auth.0.cluster_ca_certificate}"
  sensitive = true
}

output "host" {
  value     = "${google_container_cluster.primary.endpoint}"
  sensitive = true
}
