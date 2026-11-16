# Asynchronous data flow — YAS

## Topology

```
PostgreSQL (product, order DBs)
    → Debezium connectors (Kafka Connect :8083)
    → Kafka topics (product / order CDC)
    → consumers: search, recommendation
```

## Connector registration

Script: `./start-source-connectors.sh`

- `PUT http://localhost:8083/connectors/product-connector/config` ← `kafka/connects/debezium-product.json`
- `PUT http://localhost:8083/connectors/order-connector/config` ← `kafka/connects/debezium-order.json`

## Consumers in source

| Component | Mechanism | Topic config |
|-----------|-----------|--------------|
| `search` | `@KafkaListener` `ProductSyncDataConsumer` | `${product.topic.name}` |
| `recommendation` | `@KafkaListener` `ProductSyncDataConsumer` | `${product.topic.name}` |

Shared message types live under `common-library` (`ProductCdcMessage`, `ProductMsgKey`, etc.).

## PII implications

- **Product CDC** — primarily catalog fields; low direct PII.
- **Order CDC** — connector present; if table include list covers `order` / `order_address` / checkout email columns, **PII can traverse Kafka**. Exact include/exclude lists are in `kafka/connects/debezium-order.json` — review before enabling for benchmarks.
- Webhook notification pipeline is separate (DB-backed events) and is **not** started in default compose.

## Unavailable

- Live topic names, consumer lag, and payload samples were not captured (Kafka not started in Phase 1).
