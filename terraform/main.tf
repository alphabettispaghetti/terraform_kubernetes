module "gke-cluster" {
  source = "node_pools"
  version = "1.19.1"

  general = {
    name = "jumperbox"
    env  = "dev"
    zone = "europe-west2-b"
  }

  master = {
    network    = "${google_compute_network.vpc.self_link}"
    subnetwork = "${google_compute_subnetwork.subnetwork-tools.self_link}"
  }

  default_node_pool = {
    node_count = 3
    remove     = false
  }

  # Optional in case we have a default pool
  node_pool = [
    {
      machine_type   = "custom-2-4096"
      disk_size_gb   = 40
      min_node_count = 1
      max_node_count = 3
    },
    {
      machine_type   = "custom-1-2048"
      disk_size_gb   = 40
      min_node_count = 1
      max_node_count = 5
    },
  ]
}
