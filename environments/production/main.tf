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
  description = "Provider-read Neon organization ID supplied at reviewed plan/apply time."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^org-[a-z0-9-]+$", var.neon_org_id))
    error_message = "neon_org_id must be a provider-read Neon organization ID beginning with org-."
  }
}

module "neon" {
  source = "../../modules/neon/terraform"

  neon_org_id              = var.neon_org_id
  project_name             = "embedded-alerts-prod"
  region_id                = "aws-us-east-2"
  default_branch_protected = true
  branch_name              = "production"
  canonical_database_name  = "canonical"
  app_role_name            = "embedded_alerts_app"
  auth_role_name           = "embedded_alerts_auth"
  auth_database_name       = "auth"
}

# State-address transition from the legacy production root. These declarations
# are inert until a reviewed production plan/apply runs against the existing
# state backend/workspace; they must produce moves only, never replacements.
moved {
  from = neon_project.prod
  to   = module.neon.neon_project.prod
}

moved {
  from = neon_role.auth
  to   = module.neon.neon_role.auth
}

moved {
  from = neon_database.auth
  to   = module.neon.neon_database.auth
}
