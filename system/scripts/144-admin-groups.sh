#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - Administrative Groups"
echo "======================================"

for group in wheel netdev; do
    if getent group "$group" >/dev/null 2>&1; then
        echo "[OK] $group existe."
    else
        groupadd "$group"
        echo "[OK] $group criado."
    fi
done

echo
echo "[OK] Grupos administrativos preparados."