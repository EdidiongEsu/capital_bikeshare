## if you get any error that a resource already exists, please change name as some of resources need a unique identifier in GCP

locals {
  ## gcs bucket storage name
  data_lake_bucket = "capitalbike_share"
}

variable "project" {
  description = "GCP Project ID"
  type = string
  ## change project ID to your project ID
  default = "change to your project ID"
}

variable "region" {
  description = "Region for GCP resources. Choose as per your location: https://cloud.google.com/about/locations"
  type = string
  #Update the below to your desired region
  default = "europe-west1"
}

variable "storage_class" {
  description = "Storage class type for your bucket. Check official docs for more info."
  type = string
  default = "STANDARD"
}

variable "vm_image" {
  ## this is for the compute. Change machine image to match your requirements. A default template is used here.
  description = "Base image for your Virtual Machine."
  type = string
  default = "ubuntu-os-cloud/ubuntu-2004-lts"
}

variable "BQ_DATASET" {
  description = "BigQuery Dataset that raw data (from GCS) will be written to"
  type = string
  default = "capitalbike_share"
}

variable "dbt_stg_dataset" {
  description = "BigQuery Dataset for storing dbt staging models"
  type = string
  default = "capital_bikeshare_dbt"
}

variable "dbt_core_dataset" {
  description = "BigQuery Dataset for storing dbt production models"
  type = string
  default = "prod_capital_bikeshare"
}