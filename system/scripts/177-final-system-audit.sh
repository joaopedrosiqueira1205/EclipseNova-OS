#!/usr/bin/env bash
set -euo pipefail
fail=0
echo "== EclipseNova final system audit =="
for c in bash gcc make python3 systemctl ip; do
  command -v "$c" >/dev/null && echo "[OK] $c" || { echo "[FALTA] $c"; fail=1; }
done
[ -f /etc/os-release ] || { echo "[FALTA] /etc/os-release"; fail=1; }
[ -f /etc/fstab ] || { echo "[FALTA] /etc/fstab"; fail=1; }
grep -q '^ID=eclipsenova' /etc/os-release 2>/dev/null || { echo "[ERRO] ID do sistema"; fail=1; }
exit "$fail"
