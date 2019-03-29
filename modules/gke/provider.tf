provider "google" {
  credentials = "${file("~/.gcloud/service_account_keys/${lookup(var.global, "project")}.json")}"
  project     = "${lookup(var.global, "project")}"
  region      = "${lookup(var.global, "region")}"
}

# locals {
#   credentials_location = "~/.gcloud/service_account_keys/${lookup(var.global, "project")}.json"
# }
