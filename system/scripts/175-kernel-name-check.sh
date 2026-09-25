#!/usr/bin/env bash
set -euo pipefail
KVER="${1:-7.1.8}"
EXPECTED="/boot/vmlinuz-${KVER}-eclipsenova"
[ -f "$EXPECTED" ] && echo "[OK] $EXPECTED" || {
  echo "[PENDENTE] kernel final esperado: $EXPECTED"
  exit 2
}
