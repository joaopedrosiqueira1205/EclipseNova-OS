#!/usr/bin/env bash
set -euo pipefail
echo "== EclipseNova firewall policy =="
if command -v nft >/dev/null 2>&1; then
  nft list ruleset || true
elif command -v iptables >/dev/null 2>&1; then
  iptables -S || true
else
  echo "[PENDENTE] backend de firewall"
fi
