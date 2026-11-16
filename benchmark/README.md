# YAS Microservices — Phase 1 Benchmark Documentation

Satark AI Enterprise PII Benchmark preparation package for the **YAS (Yet Another Shop)** e-commerce microservices platform.

| Field | Value |
|-------|-------|
| Fork org | https://github.com/satark-enterprise-benchmark/yas-microservices |
| Upstream | https://github.com/nashtech-garage/yas |
| Baseline SHA | `179e813568c345bad3fce985088b5535e57481aa` (branch `main`) |
| Acquisition | 2026-11-16T21:10:24Z |
| License | MIT |
| Panel relevance | Service-to-service PII movement across customer, cart, order, payment, location, and related services |

## Readiness status

| Gate | Status | Notes |
|------|--------|-------|
| Inspected | **Pass** | Source tree, compose files, Liquibase changelogs, entities, and Kafka connectors reviewed |
| Structure | **Pass** | This `benchmark/` package |
| Environment | **Partial** | Docker present on inspection host; Maven not installed; system Java runtime not usable for local builds |
| Startup | **Not verified** | Full `docker compose up` was **not** executed during Phase 1 |

## Package layout

```
benchmark/
  README.md
  repository-metadata.json
  architecture/
  database/
  data-flow/
  environment/
  diagrams/
  scripts/
  reports/
```

## Quick orientation

YAS is a Maven multi-module Spring Boot 4 / Java 25 ecommerce platform with Next.js storefront and backoffice, Keycloak identity, PostgreSQL (database-per-service), Kafka + Debezium CDC, Redis, and optional Elasticsearch search / observability stacks.

Primary PII surfaces: Keycloak user profiles (email, name), location `address` rows (contactName, phone, address lines), order shipping/billing addresses and email, cart `customerId`, and payment/order linkage.

Upstream already ships production-quality Docker Compose (`docker-compose.yml`, `docker-compose.search.yml`, `docker-compose.o11y.yml`). No `docker-compose.benchmark.yml` was added.

## Scripts

```bash
./benchmark/scripts/check-prerequisites.sh
./benchmark/scripts/validate-environment.sh
./benchmark/scripts/environment-info.sh
```

## Upstream startup (documented, not Phase-1 verified)

See `environment/startup-guide.md` and the repository root `README.md`.
