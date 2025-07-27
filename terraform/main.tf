provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_storage_bucket" "file_bucket" {
  name          = var.gcs_bucket_name
  location      = var.region
  force_destroy = true
}

resource "google_bigquery_dataset" "my_dataset" {
  dataset_id                 = var.bq_dataset_name
  location                   = var.region
  delete_contents_on_destroy = true
}

resource "google_service_account" "my_sa" {
  account_id   = var.service_account_id
  display_name = "Service Account"
}

resource "google_project_iam_member" "storage_access" {
  project = var.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.my_sa.email}"
}

resource "google_project_iam_member" "bq_access" {
  project = var.project_id
  role    = "roles/bigquery.dataEditor"
  member  = "serviceAccount:${google_service_account.my_sa.email}"
}

terraform {
  backend "gcs" {
    bucket = "ecp-tech-assessment-bucket"
    prefix = "terraform/state"
  }
}

