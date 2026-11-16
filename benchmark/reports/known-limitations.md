# Known limitations — YAS

1. **Startup not verified** in Phase 1 — do not claim a runnable benchmark environment yet.
2. **Delivery service is a stub** — empty controller/service; no delivery PII APIs.
3. **Webhook & recommendation** commented out of default `docker-compose.yml`.
4. **No dedicated notification microservice** (email/SMS); webhook notifications only when enabled.
5. **Inspection host lacks Maven and usable Java** — non-Docker builds blocked.
6. **Hosts file and full compose health** not confirmed on inspection machine.
7. **Secret values** in `.env` are not documented here; some keys reference external AI providers.
8. **payment-paypal** module exists but is not called out as a first-class long-running compose service in the core service list reviewed.
9. **K8s deployment** documented upstream but not assessed for Phase 1 local benchmark.
10. **Exact Debezium include-list / topic names for order PII** require connector JSON review at scenario design time — not runtime-validated here.
