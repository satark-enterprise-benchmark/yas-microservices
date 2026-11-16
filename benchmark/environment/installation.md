# Installation — YAS

Phase 1 did **not** install or build the stack. The following mirrors upstream instructions for future Environment/Startup gates.

## 1. Obtain source

This fork is already cloned at the benchmark baseline SHA. Ensure branch `benchmark-preparation` for documentation work; runtime baseline commit is `179e813568c345bad3fce985088b5535e57481aa`.

## 2. Host networking

Add upstream-required `/etc/hosts` entries (see `prerequisites.md`).

## 3. Environment file

Compose reads `.env` at repo root (`COMPOSE_FILE`, Postgres, Kafka, Redis, `YAS_SERVICES_*`, OTEL, etc.).

## 4. Start dependencies + services

```bash
docker compose up
# or core only:
docker compose -f docker-compose.yml up
```

Optional overlays:

- Search: `docker-compose.search.yml`
- Observability: `docker-compose.o11y.yml`

Upstream notes first-run flakiness: stop and `docker compose up` again if storefront/backoffice misbehave.

## 5. Register CDC connectors

```bash
./start-source-connectors.sh
```

## 6. Non-Docker local builds (optional)

Requires JDK 25 + Maven (not present on inspection host). Build modules with `mvn clean install` per upstream CI patterns.

## Benchmark package

No additional application install steps — documentation-only under `benchmark/`.
