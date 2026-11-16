# Prerequisites — YAS

## Documented by upstream (root README)

- Docker / Docker Compose
- Host file entries:
  - `127.0.0.1 identity api.yas.local pgadmin.yas.local storefront backoffice loki tempo grafana elasticsearch kafka`
- **≥ 16 GB RAM** recommended for full stack; core-only: `docker compose -f docker-compose.yml up`
- After first healthy start: `./start-source-connectors.sh`

## Observed on Phase 1 inspection host (2026-11-17)

| Tool | Status |
|------|--------|
| Docker | 29.8.0 present |
| Docker Compose | available via `docker compose` |
| Maven (`mvn`) | **not installed** |
| Java | **no usable runtime** (`java -version` failed) |
| Node.js | present (`/opt/homebrew/bin/node`) — only needed for non-Docker frontend work |
| Git | present (fork clone) |

## Benchmark scripts

Run from repo root:

```bash
./benchmark/scripts/check-prerequisites.sh
./benchmark/scripts/validate-environment.sh
./benchmark/scripts/environment-info.sh
```

## Secrets / config

Project ships `.env` used by Compose. Treat as sensitive in real deployments; Phase 1 docs do not reprint secret values.
