# Shutdown guide — YAS

## Docker Compose

From repository root:

```bash
docker compose down
```

Remove volumes only if you intend to wipe databases (destructive):

```bash
docker compose down -v
```

## CDC

Stopping Compose stops Kafka Connect; connectors will need re-registration after next start via `./start-source-connectors.sh`.

## Local non-Docker processes

If any `mvn spring-boot:run` / `next dev` processes were started outside Compose, terminate those PIDs manually. Phase 1 did not start them.

## Benchmark scripts

Scripts under `benchmark/scripts/` are read-only checks — no shutdown daemon.
