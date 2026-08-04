# eal-infra

Docker Compose, Kubernetes, Kustomize, Argo CD, Terraform, observability, and runbooks for Embedded Alerts.

**Product:** Embedded Alerts — Embedding-based alerting for semantically relevant new information.

Define semantic alert rules, ingest source documents, compare embeddings, rank matches, and deliver explainable notifications.

## Safety and production boundary

Similarity scores are ranking signals, not truth guarantees. Production ingestion must respect source terms, robots rules, privacy requirements, retention limits, and notification consent.

This repository is an executable bootstrap, not a production deployment. Before live
use, add authentication, tenant authorization, rate limits, durable migrations,
observability, backups, incident response, dependency review, and secret management.
            ## Services

            - `eal-api`
- `eal-mash-web`
- `eal-leptos-web`
- `eal-dioxus-web`
- `eal-sync`

            The checked-in images use version tags as placeholders. Production GitOps must pin
            immutable digests produced by verified CI, use an external secrets provider, and
            configure managed PostgreSQL/Supabase, backups, TLS, network policy, autoscaling,
            dashboards, and alerts.

            ```bash
            ./scripts/validate.sh
            docker compose up
            ```
