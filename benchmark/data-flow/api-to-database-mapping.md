# API → database mapping — YAS

Representative mappings from controllers/entities (not an exhaustive OpenAPI dump). Aggregated Swagger is intended at `http://api.yas.local/swagger-ui/` when the stack is running.

## customer service

| API area | Persistence |
|----------|-------------|
| `/backoffice/customers*` profile CRUD | Keycloak user store (+ customer DB for address links) |
| `/storefront/customer/profile` | Keycloak |
| User address APIs | `customer.user_address` + calls to location DB |

## location service

| API | Tables |
|-----|--------|
| `/storefront/addresses` CRUD | `address` (+ geo FKs) |

## cart service

| API | Tables |
|-----|--------|
| `/storefront/cart/items*` | `cart_item` |

## order service

| API area | Tables |
|----------|--------|
| Checkout APIs | `checkout`, `checkout_item` |
| Order APIs | `order`, `order_item`, `order_address` |

PII columns of interest: `email`, `customer_id`, `order_address.contact_name/phone/address_*`.

## payment service

| API area | Tables |
|----------|--------|
| Payment initiate/capture/provider | `payment`, `payment_provider` |

## identity

Keycloak HTTP endpoints → `keycloak` PostgreSQL database (schema owned by Keycloak).

## Unavailable without runtime

Exact nginx path prefixes per service and full OpenAPI operation list were not captured from a live gateway in Phase 1.
