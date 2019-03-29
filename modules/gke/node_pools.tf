# Manages a Node Pool resource within GKE
# https://www.terraform.io/docs/providers/google/r/container_node_pool.html
resource "google_container_node_pool" "node_pool" {
  count = "${length(var.node_pools)}"

  name       = "${local.name_prefix}-${lookup(var.global, "location")}-pool-${count.index}"
  location   = "${lookup(var.global, "location")}"
  node_count = "${lookup(var.node_pools[count.index], "node_count")}"
  cluster    = "${google_container_cluster.primary.name}"

  node_config {
    disk_size_gb    = "${lookup(var.node_pools[count.index], "disk_size_gb")}"
    disk_type       = "${lookup(var.node_pools[count.index], "disk_type", "pd-standard")}"
    image_type      = "${lookup(var.node_pools[count.index], "image")}"
    local_ssd_count = "${lookup(var.node_pools[count.index], "local_ssd_count")}"
    machine_type    = "${lookup(var.node_pools[count.index], "machine_type")}"

    oauth_scopes    = "${split(",", lookup(var.node_pools[count.index], "oauth_scopes"))}"
    preemptible     = "${lookup(var.node_pools[count.index], "preemptible")}"
    service_account = "${lookup(var.node_pools[count.index], "service_account")}"
    labels          = "${var.labels}"
    tags            = "${var.tags}"
    metadata        = "${var.metadata}"
  }

  autoscaling {
    min_node_count = "${lookup(var.node_pools[count.index], "min_node_count")}"
    max_node_count = "${lookup(var.node_pools[count.index], "max_node_count")}"
  }

  management {
    auto_repair  = "${lookup(var.node_pools[count.index], "auto_repair")}"
    auto_upgrade = "${lookup(var.node_pools[count.index], "auto_upgrade")}"
  }
}

locals {
  name_prefix = "${google_container_cluster.primary.name}-${lookup(var.global, "env")}"
}

# This data source fetches the project name, and provides the appropriate URLs to use for container registry for this project.
# https://www.terraform.io/docs/providers/google/d/google_container_registry_repository.html
data "google_container_registry_repository" "registry" {}

# Provides access to available Google Container Engine versions in a location for a given project.
# https://www.terraform.io/docs/providers/google/d/google_container_engine_versions.html
