#!/usr/bin env bash


# Dynamically gather current projecct id space
export TF_VAR_project="$(gcloud config list --format 'value(core.project)')"

export TF_VAR_user="admin"
