# Technology stack — YAS

Observed from `pom.xml`, frontend `package.json`, Docker Compose, and docs at baseline SHA.

## Languages & runtimes

| Layer | Technology | Evidence |
|-------|------------|----------|
| Backend | Java **25** | `<java.version>25</java.version>` in root `pom.xml` |
| Backend framework | Spring Boot **4.0.2** | `spring-boot-starter-parent` |
| Frontends | Next.js **14.2.x**, React **18.3** | `storefront/package.json` |
| Identity | Keycloak (Spring Boot starter 25.0.3) | pom + `identity` compose service |
| Build | Maven multi-module | root `pom.xml` |
| Migrations | Liquibase SQL changelogs | `*/src/main/resources/db/changelog/` |

## Data & messaging

| Concern | Technology |
|---------|------------|
| Primary OLTP | PostgreSQL (one logical DB per service) |
| Cache | Redis |
| Search | Elasticsearch (`docker-compose.search.yml`) |
| Messaging | Confluent Kafka 7.7.1, Zookeeper, Kafka Connect, Debezium |
| CDC | `kafka/connects/debezium-product.json`, `debezium-order.json` |

## Cross-cutting

| Concern | Technology |
|---------|------------|
| API docs | Swagger UI container + per-service OpenAPI |
| Resilience | Resilience4j |
| Observability | OpenTelemetry, Grafana, Loki, Prometheus, Tempo (`docker-compose.o11y.yml`) |
| CI | GitHub Actions per service |
| Quality | Checkstyle, SonarCloud, Gitleaks, Testcontainers |
| Orchestration (alt) | Kubernetes charts under `k8s/` |

## Host inspection notes (Phase 1)

- Docker Engine **29.8.0** available.
- `mvn` **not found**.
- `java -version` failed (no usable JRE on PATH) — local non-Docker builds not ready.
