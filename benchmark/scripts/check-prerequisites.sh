#!/usr/bin/env bash
# Safe prerequisite checks for YAS benchmark (read-only).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT"

echo "=== YAS prerequisite check ==="
echo "Repo root: $ROOT"
echo

pass=0
fail=0
warn=0

check_cmd() {
  local name="$1"
  if command -v "$name" >/dev/null 2>&1; then
    echo "[PASS] $name: $(command -v "$name")"
    pass=$((pass + 1))
  else
    echo "[FAIL] $name not found on PATH"
    fail=$((fail + 1))
  fi
}

check_cmd docker
check_cmd git

if docker compose version >/dev/null 2>&1; then
  echo "[PASS] docker compose: $(docker compose version | head -n1)"
  pass=$((pass + 1))
else
  echo "[FAIL] docker compose unavailable"
  fail=$((fail + 1))
fi

if command -v mvn >/dev/null 2>&1; then
  echo "[PASS] mvn present"
  pass=$((pass + 1))
else
  echo "[WARN] mvn not found (Docker-based runs may still work)"
  warn=$((warn + 1))
fi

if command -v java >/dev/null 2>&1 && java -version >/dev/null 2>&1; then
  echo "[PASS] java runtime responds"
  pass=$((pass + 1))
else
  echo "[WARN] usable java runtime not detected"
  warn=$((warn + 1))
fi

for f in docker-compose.yml postgres_init.sql pom.xml .env; do
  if [[ -f "$f" ]]; then
    echo "[PASS] found $f"
    pass=$((pass + 1))
  else
    echo "[FAIL] missing $f"
    fail=$((fail + 1))
  fi
done

echo
echo "Summary: pass=$pass warn=$warn fail=$fail"
if [[ "$fail" -gt 0 ]]; then
  exit 1
fi
exit 0
