variable "username" {
  default = "admin"
}
variable "password" {
}
variable "cluster_name" {
  type = "string"
  default = ""
  description = "The name of the cluster to create"
}
variable "node_pools" {
  type              = "list"
  default           = []
  description       = "Settings for node pool(s), provide as list of dictionaries"
}

variable "global" {
  type = "map"
  default = {}
  description = "Global variables"
}
