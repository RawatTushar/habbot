variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}

variable "region" {
  description = "Google Cloud region"
  type        = string
  default     = "asia-south1"
}

variable "bucket_name" {
  description = "Globally unique name for the D0 raw landing bucket"
  type        = string
}

variable "dataset_id" {
  description = "BigQuery D1 staged/enforced dataset ID"
  type        = string
  default     = "d1_staged_enforced"
}