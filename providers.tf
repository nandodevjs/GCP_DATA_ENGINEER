provider "google" {
    project = var.project_id
    region  = var.region
}

terraform {
    backend "gcs" {
      bucket = "state-terraform-02"
      prefix = "terraform/state"
    }
    required_providers {
      google = {
        source = "hashicorp/google"
        version = "3.67.0"
      }
    }
    
}
