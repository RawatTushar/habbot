resource "google_storage_bucket" "d0_raw_landing" {
  name     = var.bucket_name
  location = var.region

  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }

  labels = {
    layer = "d0"
    type  = "raw-landing"
  }
}

resource "google_bigquery_dataset" "d1_staged_enforced" {
  dataset_id                      = var.dataset_id
  location                        = var.region
  default_partition_expiration_ms = 5184000000
  default_table_expiration_ms     = 5184000000

  labels = {
    layer = "d1"
    type  = "staged-enforced"
  }
}

resource "google_bigquery_table" "student_onboarding" {
  dataset_id = google_bigquery_dataset.d1_staged_enforced.dataset_id
  table_id   = "student_onboarding"

  schema = jsonencode([
    {
      name = "student_id"
      type = "STRING"
      mode = "REQUIRED"
    },
    {
      name = "student_name"
      type = "STRING"
      mode = "REQUIRED"
    },
    {
      name = "region"
      type = "STRING"
      mode = "REQUIRED"
    },
    {
      name = "has_learning_difficulty"
      type = "BOOL"
      mode = "REQUIRED"
    }
  ])
}
resource "google_service_account" "raw_ingestion" {
  account_id   = "raw-ingestion"
  display_name = "D0 Raw Landing Ingestion"
}
resource "google_storage_bucket_iam_member" "raw_ingestion_writer" {
  bucket = google_storage_bucket.d0_raw_landing.name
  role   = "roles/storage.objectCreator"

  member = "serviceAccount:${google_service_account.raw_ingestion.email}"

  condition {
    title       = "AllowRawObjectUploads"
    description = "Allow the ingestion identity to create objects only in the raw landing bucket."
    expression  = "resource.name.startsWith('projects/_/buckets/${var.bucket_name}/objects/')"
  }
}
resource "google_bigquery_row_access_policy" "learning_difficulty_protection" {
  dataset_id = google_bigquery_dataset.d1_staged_enforced.dataset_id
  table_id   = google_bigquery_table.student_onboarding.table_id
  policy_id  = "protect_learning_difficulty"

  filter_predicate = "has_learning_difficulty = FALSE"

  grantees = [
    "allAuthenticatedUsers"
  ]
}