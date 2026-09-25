#!/usr/bin/env bash
set -euo pipefail
ROOT="${1:-$(pwd)}"
echo "== EclipseNova repository audit =="
echo "Raiz: $ROOT"
echo
echo "-- referencias antigas --"
grep -RInE 'SolarNexum|solarnexum|SOLARNEXUM' "$ROOT" \
  --exclude-dir=.git --exclude='*.zip' || true
echo
echo "-- kernels EclipseNova esperados --"
grep -RInE 'vmlinuz-.*eclipsenova|vmlinuz-.*solarnexum' "$ROOT/system" 2>/dev/null || true
echo
echo "-- scripts shell --"
find "$ROOT" -type f -name '*.sh' -print0 | while IFS= read -r -d '' f; do
  bash -n "$f" || echo "SINTAXE: $f"
done
echo "Auditoria concluida. Corrija qualquer referencia antiga antes do build."
