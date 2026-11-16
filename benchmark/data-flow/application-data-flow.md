# Application data flow — YAS

## Synchronous user flows (PII-focused)

### 1. Authenticate

Browser → nginx → storefront/backoffice → BFF → Keycloak (`identity`). Session/token established via BFF pattern described in `docs/README.md`.

### 2. Manage profile / addresses

1. Customer service reads/writes Keycloak user representations (`email`, names).
2. Address create/update goes to **location** service (`POST/PUT /storefront/addresses`).
3. Customer service stores `user_address` linking Keycloak `userId` to `addressId`.
4. Default address resolution: customer → location `getAddressById`.

### 3. Cart

Authenticated calls to cart service `/storefront/cart/items*`; persistence keyed by `customerId`.

### 4. Checkout / place order

1. Order/checkout APIs accept customer email and shipping/billing address data.
2. Order service may call customer profile (`CustomerService.getCustomer()` → `/storefront/customer/profile`).
3. PII persisted on `checkout` / `order` / `order_address`.
4. Payment service initiates/captures payment and updates order status via REST.

### 5. Admin backoffice

Backoffice BFF → customer admin endpoints (`/backoffice/customers`, email lookup, profile update/delete) expose identity PII to operators.

## Asynchronous flows

See `asynchronous-data-flow.md` — Debezium CDC from product/order DBs into Kafka; search/recommendation consumers.

## Delivery / notification

- **Delivery**: stub only — no implemented PII flow.
- **Notification**: no dedicated mail/SMS service found; `webhook` persists `WebhookEventNotification` records when enabled.
