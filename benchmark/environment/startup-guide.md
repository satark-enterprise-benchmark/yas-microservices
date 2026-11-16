# Startup guide — YAS

> **Phase 1 status:** Startup **not verified**. Commands below are transcribed from upstream README and scripts.

## Recommended sequence

1. Confirm prerequisites (`./benchmark/scripts/check-prerequisites.sh`).
2. Ensure `/etc/hosts` entries exist.
3. From repository root:

```bash
docker compose up
```

4. Wait until containers are healthy (RAM ≥ 16 GB recommended).
5. Register Debezium connectors:

```bash
./start-source-connectors.sh
```

6. Smoke URLs (upstream):

| URL | Purpose |
|-----|---------|
| http://storefront/ | Storefront (admin/password per README) |
| http://backoffice/ | Backoffice |
| http://api.yas.local/swagger-ui/ | APIs |
| http://identity/ | Keycloak |
| http://pgadmin.yas.local/ | pgAdmin |
| http://grafana/ | Observability (if o11y profile enabled) |
| http://elasticsearch/ | ES (if search profile enabled) |

Helper script `start-yas.sh` currently runs `docker compose -f docker-compose.yml up -d` (verify before relying on it).

## Startup verification checklist (future gate)

- [ ] `docker compose ps` shows expected services Up
- [ ] Keycloak login works
- [ ] Storefront loads
- [ ] Swagger reachable
- [ ] Connectors listed on `:8083/connectors`
- [ ] Create address / order path exercises PII tables

**None of the above were completed in Phase 1.**
