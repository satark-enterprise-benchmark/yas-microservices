# Application overview — YAS

## Purpose

YAS (**Yet Another Shop**) is an open-source ecommerce training / reference platform that implements a typical Java microservice architecture: product catalog, cart, checkout/order, payment, inventory, tax, promotion, ratings, media, location, customer profiles (backed by Keycloak), BFFs for SPA frontends, and Kafka CDC into search/recommendation consumers.

## Business capabilities observed in source

| Capability | Modules | Notes |
|------------|---------|-------|
| Identity / login | `identity/` (Keycloak), BFFs | BFF + SameSite cookies + tokens (documented in `docs/README.md`) |
| Customer profile | `customer/` | Keycloak Admin API for user CRUD; local `user_address` links to location addresses |
| Addresses | `location/` | Canonical address entity with contactName, phone, lines, geo FKs |
| Catalog | `product/`, `media/` | Product and media assets |
| Cart | `cart/` | Cart items keyed by `customerId` + `productId` |
| Checkout / order | `order/` | Checkout, order, order_address (shipping/billing PII copies) |
| Payment | `payment/`, `payment-paypal/` | Payment records linked to order/checkout |
| Inventory / tax / promotion | `inventory/`, `tax/`, `promotion/` | Supporting commerce |
| Search | `search/` | Elasticsearch; consumes product CDC from Kafka |
| Recommendation | `recommendation/` | Optional; CDC consumer; commented out in compose |
| Webhooks | `webhook/` | Event notification persistence; commented out in compose |
| Delivery | `delivery/` | Maven module present; **stub only** (empty controller/service) |
| Frontends | `storefront/`, `backoffice/` | Next.js 14 SPAs |
| Gateways | `storefront-bff/`, `backoffice-bff/` | Spring Cloud Gateway BFFs |
| Edge | `nginx/` | Reverse proxy for `*.yas.local` hostnames |
| Sample data | `sampledata/` | Seed loader service |

## PII-relevant journeys (source-level)

1. **Registration / profile** — Customer data stored in Keycloak (`email`, `username`, `firstName`, `lastName`); exposed via customer service REST.
2. **Address book** — Location service stores `contactName`, `phone`, address lines; customer service associates addresses to Keycloak `userId`.
3. **Cart** — Items stored under authenticated `customerId`.
4. **Checkout / order** — Order and checkout persist `email`, shipping/billing `OrderAddress` (contactName, phone, address lines), and `customerId`.
5. **Payment** — Payment rows reference `orderId` / `checkoutId` (indirect PII via order).
6. **Async** — Debezium CDC from product/order PostgreSQL databases into Kafka topics; search/recommendation consume product CDC. Order CDC connector exists under `kafka/connects/debezium-order.json` (potential async PII replication surface).

## Maintained status

Upstream NashTech Garage project is actively developed (CI workflows per service, recent commits at baseline). This fork freezes baseline SHA `179e813…` for benchmark reproducibility.
