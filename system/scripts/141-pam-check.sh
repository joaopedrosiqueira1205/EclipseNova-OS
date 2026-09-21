#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - PAM Check"
echo "======================================"

ERRORS=0

for file in \
    /usr/lib/libpam.so \
    /etc/pam.d/other
do
    if [ -e "$file" ]; then
        echo "[OK] $file"
    else
        echo "[ERRO] $file"
        ERRORS=$((ERRORS + 1))
    fi
done

if [ "$ERRORS" -gt 0 ]; then
    exit 1
fi

echo "[OK] PAM encontrado."