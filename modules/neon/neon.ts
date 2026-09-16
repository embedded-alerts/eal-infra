export const neonInfrastructure = Object.freeze({
  schema: "embedded-alerts.neon-infra/v1",
  terraformModule: "./terraform",
  environmentsRoot: "../../environments",
  credentials: Object.freeze({
    apiKeyEnv: "NEON_API_KEY",
    orgIdTerraformVariable: "neon_org_id",
  }),
  applyPolicy: "operator-reviewed-only",
});

export default neonInfrastructure;
