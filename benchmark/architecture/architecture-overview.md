# Architecture overview — YAS

## Pattern

**Microservice mesh + BFF + reverse proxy**, with **database-per-service** on a shared PostgreSQL instance (separate logical databases), **Keycloak** for IdP, and **Kafka + Debezium CDC** for eventual consistency into search/recommendation.

```
Browser → nginx → storefront/backoffice (Next.js)
                → storefront-bff / backoffice-bff (Spring Cloud Gateway)
                → identity (Keycloak)
                → domain services (product, customer, cart, order, payment, …)
                → postgres / redis / kafka / (elasticsearch via search compose)
```

## Synchronous paths

- SPAs call BFFs; BFFs authenticate and proxy to domain services using `YAS_SERVICES_*` URLs from `.env`.
- Domain services call each other via Spring `RestClient` + `ServiceUrlConfig` (examples: `order` → `customer` profile; `customer` → `location` addresses; `payment` → `order` status; `cart` → `product`).

## Asynchronous paths

- Kafka brokers + Zookeeper + Kafka Connect (Debezium) + Kafka UI in `docker-compose.yml`.
- Connectors: `kafka/connects/debezium-product.json`, `kafka/connects/debezium-order.json`, registered by `./start-source-connectors.sh`.
- Consumers: `search` and `recommendation` `@KafkaListener` on product CDC topics.

## Observability (optional)

`docker-compose.o11y.yml` — Grafana, Loki, Tempo, Prometheus, OTEL collector.

## Deployment variants

- **Local Docker Compose** — primary Phase 1 path (documented in root README).
- **Kubernetes** — charts under `k8s/` (not exercised in Phase 1).

## Trust boundaries (PII)

| Boundary | Mechanism |
|----------|-----------|
| Browser ↔ BFF | Cookie/token BFF pattern with Keycloak |
| Service ↔ service | Internal docker network URLs; OAuth resource server configs per service |
| Service ↔ DB | JDBC to dedicated PostgreSQL database names |
| DB ↔ Kafka | Debezium connectors (order CDC may replicate address/email columns) |
