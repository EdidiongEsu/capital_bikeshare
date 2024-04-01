terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
    }
  }
}

provider "google" {
  project = var.project
  region = var.region
}

# Data Lake Bucket
resource "google_storage_bucket" "capitalbike_share" {
  name          = "${local.data_lake_bucket}" #gcs bucket name
  location      = var.region

  # Optional, but recommended settings:
  storage_class = var.storage_class
  uniform_bucket_level_access = true

  versioning {
    enabled     = true
  }

  force_destroy = true
}

# Data Warehouse
resource "google_bigquery_dataset" "dataset" {
  dataset_id = var.BQ_DATASET
  project    = var.project
  location   = var.region
}

resource "google_bigquery_dataset" "stage_dataset" {
  dataset_id = var.dbt_stg_dataset
  project    = var.project
  location   = var.region
  delete_contents_on_destroy = true
}

resource "google_bigquery_dataset" "prod_dataset" {
  dataset_id = var.dbt_core_dataset
  project    = var.project
  location   = var.region
  delete_contents_on_destroy = true
}

#VM instance
resource "google_compute_instance" "vm_instance" {
  name          = "capital-bikeshare-instance"
  project       = var.project
  machine_type  = "e2-standard-4"
  zone          = "europe-west3-c"  ## change to available region

  boot_disk {
    initialize_params {
      image = var.vm_image
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
}