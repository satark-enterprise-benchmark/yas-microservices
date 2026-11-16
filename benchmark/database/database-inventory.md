# Database inventory — YAS

## Primary engine

**PostgreSQL** — single Docker service `postgres`, multiple logical databases created by root `postgres_init.sql`.

Default compose credentials (from project `.env` / README): user `admin`, password `admin`, host `postgres` / localhost port `5432`.

## Logical databases (`postgres_init.sql`)

| Database | Owning service / use |
|----------|----------------------|
| `keycloak` | Keycloak identity |
| `media` | media |
| `product` | product |
| `cart` | cart |
| `rating` | rating |
| `order` | order (quoted identifier) |
| `location` | location |
| `inventory` | inventory |
| `promotion` | promotion |
| `tax` | tax |
| `customer` | customer |
| `payment` | payment |
| `webhook` | webhook (service optional in compose) |
| `recommendation` | recommendation (service optional in compose) |

## Other data stores

| Store | Role | Availability in core compose |
|-------|------|------------------------------|
| Redis | Cache / Spring Data Redis | Yes (`redis`) |
| Elasticsearch | Search index | Via `docker-compose.search.yml` |
| Kafka topics | CDC / async | Yes |

## Schema management

Per-service **Liquibase** under `<service>/src/main/resources/db/changelog/` (`db.changelog-master.yaml` + `ddl/` + optional `data/`).

Keycloak schema is managed by Keycloak itself against the `keycloak` database.

## PII-bearing stores (high level)

| Store | PII classes |
|-------|-------------|
| Keycloak DB | Usernames, emails, names, credentials (IdP) |
| `location.address` | contactName, phone, address lines, zip |
| `customer.user_address` | userId ↔ addressId links |
| `order.order` / `checkout` | email, customerId |
| `order.order_address` | shipping/billing contact + address PII copies |
| `cart.cart_item` | customerId |
| `payment.payment` | order/checkout linkage (indirect) |
| Order CDC topics | Potential replication of order PII |
