# Component inventory — YAS

Derived from root `pom.xml` modules, Docker Compose services, and top-level directories at baseline `179e813…`.

## Maven modules (backend)

| Module | Role | Compose service |
|--------|------|-----------------|
| `common-library` | Shared Kafka CDC helpers, configs, models | n/a (library) |
| `backoffice-bff` | Backoffice API gateway / BFF | via nginx/backoffice stack |
| `storefront-bff` | Storefront API gateway / BFF | via nginx/storefront stack |
| `cart` | Shopping cart | `cart` |
| `customer` | Customer profile + address association | `customer` |
| `inventory` | Stock | `inventory` |
| `location` | Countries/states/districts/addresses | `location` |
| `media` | Media assets | `media` |
| `order` | Checkout + orders | `order` |
| `payment` | Payments | `payment` |
| `payment-paypal` | PayPal integration | not listed as separate long-running compose app in core list (module present) |
| `product` | Catalog | `product` |
| `promotion` | Promotions | `promotion` |
| `rating` | Product ratings | `rating` |
| `search` | Elasticsearch search + CDC consumer | `docker-compose.search.yml` |
| `tax` | Tax | `tax` |
| `webhook` | Webhook + event notifications | commented out in compose |
| `sampledata` | Sample data loader | `sampledata` |
| `recommendation` | Recommendations + CDC | commented out in compose |
| `delivery` | Delivery (stub) | **not** present in `docker-compose.yml` |

## Frontends

| Path | Stack | Compose |
|------|-------|---------|
| `storefront/` | Next.js 14 / React 18 | `storefront`, `storefront-nextjs` |
| `backoffice/` | Next.js | `backoffice`, `backoffice-nextjs` |
| `automation-ui/` | UI automation tests | n/a for runtime stack |

## Infrastructure components (compose)

| Service | Image / role |
|---------|----------------|
| `nginx` | Edge reverse proxy |
| `identity` | Keycloak |
| `postgres` | PostgreSQL (multi-DB via `postgres_init.sql`) |
| `pgadmin` | DB admin UI |
| `zookeeper`, `kafka`, `kafka-connect`, `kafka-ui` | Messaging / CDC |
| `redis` | Cache / session support |
| `swagger-ui` | Aggregated API docs |

## Identity

`identity/` — Keycloak realm/theme assets for the identity container.

## Explicit stubs / incomplete components

- `delivery` — empty `DeliveryController` / `DeliveryService`.
- `webhook`, `recommendation` — implemented in source but commented out in `docker-compose.yml`.
