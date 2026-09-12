-- embedded-alerts: private application namespace inside the shared oresoftware Supabase project.
begin;

create schema if not exists embedded_alerts;
comment on schema embedded_alerts is 'embedded-alerts application namespace; Shared Auth remains authoritative for identity.';

revoke all on schema embedded_alerts from public, anon, authenticated;
alter default privileges in schema embedded_alerts revoke all on tables from public, anon, authenticated;
alter default privileges in schema embedded_alerts revoke all on sequences from public, anon, authenticated;
alter default privileges in schema embedded_alerts revoke all on functions from public, anon, authenticated;

commit;
