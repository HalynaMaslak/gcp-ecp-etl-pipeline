output "service_account_email" {
  value = google_service_account.my_sa.email
}

output "bucket_name" {
  value = google_storage_bucket.file_bucket.name
}

output "dataset_id" {
  value = google_bigquery_dataset.my_dataset.dataset_id
}
