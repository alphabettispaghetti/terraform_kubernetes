
variable "username" {
  default = "admin"
}
variable "password" {}

variable "cluster_name" {}

# https://www.terraform.io/docs/providers/google/r/container_cluster.html#tags
variable "tags" {
  type        = "list"
  default     = []
  description = "The list of instance tags applied to all nodes. Tags are used to identify valid sources or targets for network firewalls"
}

# https://www.terraform.io/docs/providers/google/r/container_cluster.html#labels
variable "labels" {
  description = "The Kubernetes labels (key/value pairs) to be applied to each node"
  type        = "map"
  default     = {}
}

# https://www.terraform.io/docs/providers/google/r/container_cluster.html#metadata
variable "metadata" {
  description = "The metadata key/value pairs assigned to instances in the cluster"
  type        = "map"
  default     = {}
}
variable "node_pools" {
  type              = "list"
  default           = []
  description       = "Settings for node pool(s), provide as list of dictionaries"
}
variable "global" {
  type        = "map"
  default     = {}
  description = "Global parameters"
}
