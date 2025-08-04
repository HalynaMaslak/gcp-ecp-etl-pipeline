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

resource "google_bigquery_table" "orders" {
  dataset_id = var.bq_dataset_name
  table_id   = "orders"

  schema = jsonencode([
    {
      name = "OrderID"
      type = "STRING"
      mode = "REQUIRED"
    },
    {
      name = "CustomerID"
      type = "STRING"
      mode = "REQUIRED"
    },
    {
      name = "OrderRegion"
      type = "STRING"
      mode = "REQUIRED"
    },
    {
      name = "OrderDate"
      type = "DATE"
      mode = "REQUIRED"
    },
    {
      name = "OrderAmount"
      type = "FLOAT"
      mode = "REQUIRED"
    },
    {
      name = "ProductID"
      type = "STRING"
      mode = "REQUIRED"
    },
    {
      name = "Quantity"
      type = "INTEGER"
      mode = "REQUIRED"
    },
    {
      name = "TotalOrderValue"
      type = "FLOAT"
      mode = "REQUIRED"
    }
  ])

  time_partitioning {
    type = "DAY"
    field = "OrderDate"
  }
}


