#!/usr/bin/env bash
set -euo pipefail
echo "== EclipseNova preflight =="
if [ "$(uname -m)" != "x86_64" ]; then
  echo "ERRO: host precisa ser x86_64"; exit 1
fi
for c in bash gcc g++ make patch tar xz git python3; do
  command -v "$c" >/dev/null || { echo "FALTA: $c"; exit 1; }
done
mem_kb=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
echo "RAM: $((mem_kb/1024)) MiB"
echo "CPU: $(nproc)"
echo "Espaco:"
df -h .
echo "OK: host basico encontrado."
