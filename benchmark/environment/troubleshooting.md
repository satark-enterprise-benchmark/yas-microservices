# Troubleshooting — YAS

## Upstream-documented issues

- **First-run SPA failures** — README: stop all containers and `docker compose up` again.
- **Insufficient RAM** — full stack wants ≥ 16 GB; use core-only compose file if constrained.
- **Missing hosts entries** — browsers cannot resolve `storefront`, `identity`, `api.yas.local`, etc.

## Phase 1 inspection host issues

| Symptom | Likely cause |
|---------|--------------|
| Cannot build with Maven | `mvn` not installed |
| `java -version` fails | No usable JRE/JDK on PATH |
| Cannot claim Startup gate | Compose stack not started during documentation |

## CDC

- Connectors fail if registered before Connect REST API is up — retry `./start-source-connectors.sh`.
- Order CDC may surprise operators with PII in Kafka — review connector JSON filters.

## Credentials

Default documented credentials (admin/password, Keycloak admin/admin, pgAdmin admin@yas.com/admin) are for local demo only. Rotate for any shared environment.

## Getting help

Upstream docs: root `README.md`, `docs/README.md`, `docs/developer-guidelines.md`.
