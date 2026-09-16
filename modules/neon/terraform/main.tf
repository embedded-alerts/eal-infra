resource "neon_project" "prod" {
  name                     = var.project_name
  org_id                   = var.neon_org_id
  region_id                = var.region_id
  default_branch_protected = var.default_branch_protected

  branch {
    name          = var.branch_name
    database_name = var.canonical_database_name
    role_name     = var.app_role_name
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "neon_role" "auth" {
  project_id = neon_project.prod.id
  branch_id  = neon_project.prod.default_branch_id
  name       = var.auth_role_name
}

resource "neon_database" "auth" {
  project_id = neon_project.prod.id
  branch_id  = neon_project.prod.default_branch_id
  name       = var.auth_database_name
  owner_name = neon_role.auth.name
}
