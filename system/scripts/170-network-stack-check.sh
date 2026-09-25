#!/usr/bin/env bash
set -euo pipefail
echo "== EclipseNova network stack =="
for c in ip iw wpa_supplicant nmcli curl; do
  command -v "$c" >/dev/null && echo "[OK] $c" || echo "[PENDENTE] $c"
done
systemctl is-enabled NetworkManager 2>/dev/null || true
