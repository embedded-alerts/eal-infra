variable "neon_org_id" {
  description = "Provider-read Neon organization ID; never guess it or commit a credential."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^org-[a-z0-9-]+$", var.neon_org_id))
    error_message = "neon_org_id must be a provider-read Neon organization ID beginning with org-."
  }
}

variable "project_name" {
  type     = string
  nullable = false
}

variable "region_id" {
  type     = string
  nullable = false
}

variable "default_branch_protected" {
  type     = bool
  nullable = false
}

variable "branch_name" {
  type     = string
  nullable = false
}

variable "canonical_database_name" {
  type     = string
  nullable = false
}

variable "app_role_name" {
  type     = string
  nullable = false
}

variable "auth_role_name" {
  type     = string
  nullable = false
}

variable "auth_database_name" {
  type     = string
  nullable = false
}
