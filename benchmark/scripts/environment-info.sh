#!/usr/bin/env bash
# Print environment inventory for benchmark reports (read-only).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT"

echo "=== YAS environment info ==="
echo "date: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
echo "repo: $ROOT"
echo "git_branch: $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo unavailable)"
echo "git_sha: $(git rev-parse HEAD 2>/dev/null || echo unavailable)"
echo "hostname: $(hostname)"
echo "uname: $(uname -a)"
echo

echo "-- docker --"
docker version 2>/dev/null | head -n 20 || echo "docker unavailable"
docker compose version 2>/dev/null || true
echo

echo "-- java / maven / node --"
java -version 2>&1 || true
mvn -version 2>&1 | head -n 5 || true
node -v 2>/dev/null || true
echo

echo "-- compose services (names) --"
if command -v rg >/dev/null 2>&1; then
  rg -n '^  [a-zA-Z0-9_-]+:' docker-compose.yml | head -n 80 || true
else
  grep -E '^  [a-zA-Z0-9_-]+:' docker-compose.yml | head -n 80 || true
fi

echo
echo "-- disk (repo) --"
du -sh . 2>/dev/null || true
