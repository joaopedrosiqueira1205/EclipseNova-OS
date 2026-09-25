#!/usr/bin/env bash
set -euo pipefail
echo "== EclipseNova boot consistency =="
grep -RIn 'solarnexum' /boot /etc 2>/dev/null && {
  echo "[ERRO] referencia antiga encontrada."; exit 1;
} || true
find /boot -maxdepth 2 -type f -print
echo "[OK] nenhuma referencia SolarNexum encontrada em /boot e /etc."
