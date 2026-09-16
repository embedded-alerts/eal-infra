# Neon modules-first migration

This change is structural only. It must not apply, import, destroy, or recreate Neon resources from CI.

## Canonical roots

- reusable module: `modules/neon/terraform`
- provider-native descriptor: `modules/neon/neon.ts`
- environment roots: `environments/preview`, `environments/staging`, `environments/production`
- production credentials: `NEON_API_KEY` plus the reviewed `neon_org_id` input; secrets stay outside Git.

## Production state transition

The legacy root owned these addresses:

- `neon_project.prod`
- `neon_role.auth`
- `neon_database.auth`

The production root now declares Terraform `moved` blocks to map them to:

- `module.neon.neon_project.prod`
- `module.neon.neon_role.auth`
- `module.neon.neon_database.auth`

Before the first production apply, initialize `environments/production` against the same production state backend/workspace used by the legacy root and run a reviewed plan. The plan must show address moves only for these three objects and **zero destroy/create replacements**. `prevent_destroy = true` remains on the Neon project.

If an operator must perform the transition manually instead of using the committed `moved` blocks, the equivalent commands against the same production state are:

```sh
terraform state mv 'neon_project.prod' 'module.neon.neon_project.prod'
terraform state mv 'neon_role.auth' 'module.neon.neon_role.auth'
terraform state mv 'neon_database.auth' 'module.neon.neon_database.auth'
```

Take a `terraform state pull` backup first, retain it outside the repository, and stop if any source address is missing or any destination already exists. Do not guess provider IDs and do not use `terraform import` unless a separately reviewed recovery plan proves state is genuinely absent.

## Validation

Credential-free CI may run only:

```sh
terraform fmt -check -recursive modules/neon/terraform environments
terraform -chdir=environments/<env> init -backend=false -lockfile=readonly -input=false
terraform -chdir=environments/<env> validate
```

A production plan/apply remains an explicit operator action after state/backend review.
