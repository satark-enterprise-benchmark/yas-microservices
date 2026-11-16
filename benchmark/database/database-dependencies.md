# Database dependencies — YAS

## Service → database

| Service | JDBC database | Notes |
|---------|---------------|-------|
| identity (Keycloak) | `keycloak` | Created in `postgres_init.sql` |
| media | `media` | `SPRING_DATASOURCE_URL=.../media` |
| product | `product` | |
| customer | `customer` | |
| cart | `cart` | |
| rating | `rating` | |
| order | `order` | |
| payment | `payment` | |
| location | `location` | |
| inventory | `inventory` | |
| promotion | `promotion` | |
| tax | `tax` | |
| sampledata | multi | Uses product/media URLs in compose |
| webhook | `webhook` | When enabled |
| recommendation | `recommendation` | When enabled |
| search | Elasticsearch | Not PostgreSQL primary |
| delivery | unavailable | No datasource wiring observed (stub module) |

## Cross-database application joins

There are **no** cross-database foreign keys. Associations are application-level:

- `customer.user_address.address_id` → `location.address.id` (REST)
- `order` shipping/billing addresses **copied** into `order_address` (denormalized PII)
- `cart.customerId` / `order.customerId` → Keycloak user id strings
- `payment.orderId` / `checkoutId` → order service identifiers

## CDC dependencies

Debezium connectors read PostgreSQL WALs/tables for product and order databases and publish to Kafka. Downstream search/recommendation depend on those topics remaining available.

## Redis

`SPRING_DATA_REDIS_HOST` / `PORT` from `.env`; used by services configured for Spring Data Redis (BFFs/session patterns — confirm per-service `application*.yml` before assuming session PII in Redis).
