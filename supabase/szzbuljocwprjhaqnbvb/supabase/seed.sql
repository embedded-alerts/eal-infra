-- Preview/local seed for embedded-alerts (auth). Runs only on local stacks and Supabase preview branches.
-- Keep it idempotent, synthetic, and inside the embedded_alerts schema. Never add real user data or credentials.
create schema if not exists embedded_alerts;
