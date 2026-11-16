# Repository assessment — YAS

## Summary

YAS is a **strong Phase 1 PII benchmark candidate**: real multi-service ecommerce flows move identity and address PII across Keycloak, customer, location, cart, order, and payment, with an additional async path via Debezium order CDC.

## Strengths

- Clear database-per-service boundaries with explicit Liquibase history
- Documented Docker Compose + hosts setup
- BFF + Keycloak auth pattern representative of enterprise meshes
- Rich CI and modular monorepo layout

## Gaps / risks for benchmark

- `delivery` stub — cannot exercise shipping-carrier PII paths
- webhook/recommendation disabled in default compose
- Heavy RAM requirements
- Java 25 / Spring Boot 4.0 may constrain tooling maturity on some hosts
- Order CDC may replicate PII into Kafka — valuable for scenarios, but must be intentional

## Readiness

| Gate | Status |
|------|--------|
| Inspected | Pass |
| Structure | Pass (this package) |
| Environment | Partial |
| Startup | Not verified |
