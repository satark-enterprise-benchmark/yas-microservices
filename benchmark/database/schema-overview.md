# Schema overview — YAS

Schemas are evolved via Liquibase; the following summarizes **entity-level** shapes observed in Java models and DDL (not a full column dump of every changelog).

## customer DB

**Table `user_address`** (`customer/.../ddl/changelog-0001.sql` + entity `UserAddress`):

- `id`, audit columns, `user_id` (Keycloak user id), `address_id`, `is_active`

Customer profile fields themselves live in **Keycloak**, mapped by `CustomerVm(id, username, email, firstName, lastName)`.

## location DB

**Entity `Address`**: `contactName`, `phone`, `addressLine1`, `addressLine2`, `city`, `zipCode`, FKs to `district`, `state_or_province`, `country`.

Supporting geo entities: Country, StateOrProvince, District (Liquibase + seed data).

## order DB

Entities:

- **`Checkout`**: `email`, `customerId`, payment/shipping references, totals, JSON `attributes` / `last_error`
- **`CheckoutItem`**: product snapshot fields, quantities, prices
- **`Order`**: `email`, `customerId`, shipping/billing `OrderAddress`, payment/delivery enums, totals
- **`OrderAddress`**: `contactName`, `phone`, `addressLine1/2`, `city`, `zipCode`, district/state/country ids **and denormalized names**
- **`OrderItem`**: line items

Liquibase: many incremental files under `order/src/main/resources/db/changelog/ddl/` (0001–0016+).

## cart DB

**`cart_item`**: composite key `(customerId, productId)`, `quantity`, audit columns.

## payment DB

**`payment`**: `orderId`, `checkoutId`, amounts, method/status enums, `gatewayTransactionId`, failure message.

**`payment_provider`**: provider configuration metadata.

## Other service DBs

product, media, inventory, tax, promotion, rating, webhook, recommendation — primarily non-identity catalog/ops data; rating may include user identifiers (inspect changelogs before assuming absence of PII).

## Elasticsearch

Search documents derived from product CDC — product-centric; confirm mappings under `search/` before treating as PII store.

## Unavailable

- Live `\d` introspection of a running Postgres was **not** performed (startup not verified).
- Keycloak realm table dump not extracted; treat IdP DB as opaque PII store.
