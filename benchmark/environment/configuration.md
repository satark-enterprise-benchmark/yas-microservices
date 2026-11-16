# Configuration — YAS

## Compose files

| File | Purpose |
|------|---------|
| `docker-compose.yml` | Core services + postgres/kafka/redis/identity/nginx |
| `docker-compose.search.yml` | Search / Elasticsearch profile |
| `docker-compose.o11y.yml` | Grafana/Loki/Tempo/Prometheus/OTEL |
| `.env` | Interpolation for compose (`COMPOSE_FILE`, hosts, ports, service URLs) |

`COMPOSE_FILE` in `.env` controls which compose files are merged.

## Service URL configuration

`.env` keys such as:

- `YAS_SERVICES_CART`, `YAS_SERVICES_CUSTOMER`, `YAS_SERVICES_ORDER`, `YAS_SERVICES_PAYMENT`, `YAS_SERVICES_PRODUCT`, `YAS_SERVICES_LOCATION`, …
- `YAS_PUBLIC_API_URL`
- `POSTGRES_*`, `KAFKA_*`, `SPRING_DATA_REDIS_*`
- OTEL exporter endpoints

Per-service Spring config: `application.properties` / `application.yaml` under each module (`application-dev.yaml` / `application-prod.yaml` for BFFs).

## Identity

Keycloak runs as `identity` service; console documented at `http://identity/` (admin/admin per README).

## Datasources

Compose injects `SPRING_DATASOURCE_URL=jdbc:postgresql://postgres:5432/<db>` per service.

## CDC

Connector JSON under `kafka/connects/`. Kafka Connect bootstrap configured in compose (`BOOTSTRAP_SERVERS=kafka:9092`).

## Recommendation / AI

`.env` references `SPRING_AI_AZURE_OPENAI_*` — **not validated** in Phase 1; recommendation service is commented out in compose.

## Benchmark note

No `benchmark/environment/docker-compose.benchmark.yml` added — upstream compose is sufficient.
