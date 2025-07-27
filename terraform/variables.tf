variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "europe-west2"
}

variable "gcs_bucket_name" {
  type = string
}

variable "bq_dataset_name" {
  type = string
}

variable "service_account_id" {
  type = string
}
