terraform {
  required_version = ">= 1.12.0, < 2.0.0"

  required_providers {
    neon = {
      source  = "kislerdm/neon"
      version = "= 0.15.0"
    }
  }
}

provider "neon" {}

variable "neon_org_id" {
  description = "Provider-read Neon organization ID supplied at plan/apply time."
  type        = string
  nullable    = false
}

module "neon" {
  source = "../../modules/neon/terraform"

  neon_org_id              = var.neon_org_id
  project_name             = "embedded-alerts-preview"
  region_id                = "aws-us-east-2"
  default_branch_protected = false
  branch_name              = "preview"
  canonical_database_name  = "canonical"
  app_role_name            = "embedded_alerts_app"
  auth_role_name           = "embedded_alerts_auth"
  auth_database_name       = "auth"
}
