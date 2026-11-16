#!/usr/bin/env bash
# Non-destructive environment validation for YAS. Does not start the stack.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT"

echo "=== YAS environment validation ==="

if [[ ! -f docker-compose.yml ]]; then
  echo "[FAIL] docker-compose.yml missing"
  exit 1
fi

echo "[INFO] Validating compose file syntax (docker compose config)"
if docker compose -f docker-compose.yml config >/dev/null; then
  echo "[PASS] docker-compose.yml parses"
else
  echo "[FAIL] docker-compose.yml failed to parse"
  exit 1
fi

echo "[INFO] Checking whether core containers are already running (informational)"
if docker compose -f docker-compose.yml ps >/dev/null 2>&1; then
  docker compose -f docker-compose.yml ps || true
else
  echo "[WARN] could not query compose ps"
fi

echo "[INFO] Kafka Connect connectors endpoint (optional)"
if curl -fsS --max-time 3 http://localhost:8083/connectors >/dev/null 2>&1; then
  echo "[PASS] Kafka Connect reachable at :8083"
  curl -fsS --max-time 3 http://localhost:8083/connectors || true
else
  echo "[WARN] Kafka Connect not reachable (stack likely not started)"
fi

echo "[INFO] Postgres port 5432 (optional)"
if (echo >/dev/tcp/127.0.0.1/5432) >/dev/null 2>&1; then
  echo "[PASS] something listening on 5432"
else
  echo "[WARN] nothing listening on 5432"
fi

echo
echo "Validation finished. Startup remains unverified unless services above are healthy."
