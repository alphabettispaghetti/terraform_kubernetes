module "gke-cluster" {
  source = "google-terraform-modules/kubernetes-engine/google"
  version = "1.19.1"

  general = {
    name = "mycluster"
    env  = "prod"
    zone = "europe-west1-b"
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
      machine_type   = "g1-small"
      disk_size_gb   = 20
      node_count     = 3
      min_node_count = 2
      max_node_count = 4
    },
    {
      disk_size_gb   = 30
      node_count     = 2
      min_node_count = 1
      max_node_count = 3
    },
  ]
}
