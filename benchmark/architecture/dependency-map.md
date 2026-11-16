# Dependency map — YAS

## Runtime dependency graph (logical)

```
storefront (Next.js) ──► storefront-bff ──► customer, product, cart, order, payment, location, rating, …
backoffice (Next.js) ──► backoffice-bff ──► product, media, customer, inventory, tax, promotion, …
customer ──► location (addresses); customer ──► Keycloak Admin API
order ──► customer (profile); order ──► product; order ──► promotion
cart ──► product
payment ──► order (status updates); payment ──► media (provider assets)
search ──► Kafka (product CDC); search may call product service
recommendation ──► Kafka (product CDC)
Debezium connectors ──► postgres product / order DBs ──► Kafka topics
All JDBC services ──► postgres (named databases)
BFFs / services ──► redis (as configured)
identity (Keycloak) ──► postgres/keycloak
nginx ──► frontends, BFFs, swagger, identity hostnames
```

## Maven inter-module

Most services depend on `common-library` for shared CDC message types, exceptions, and config helpers. Frontends are separate npm projects (not Maven modules).

## Infrastructure depends_on (compose highlights)

From `docker-compose.yml`: domain services depend on `postgres` (and typically identity/network readiness). Kafka Connect depends on `kafka`. Search stack is layered via `COMPOSE_FILE` / `docker-compose.search.yml`.

## PII-sensitive edges (for benchmark design)

| From | To | PII content |
|------|----|-------------|
| Keycloak | customer API | email, names, user id |
| customer | location | address ids → contactName, phone, address lines |
| order | customer | fetches profile during checkout flows |
| browser/BFF | order | email + shipping/billing addresses persisted |
| order DB | Kafka (Debezium order connector) | may include email/address columns in CDC payloads |
| payment | order | order/checkout identifiers (join to PII) |
