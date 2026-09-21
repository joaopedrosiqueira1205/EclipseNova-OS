#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - cURL Check"
echo "======================================"

if ! command -v curl >/dev/null 2>&1; then
    echo "[ERRO] curl nao encontrado."
    exit 1
fi

curl --version

echo
echo "SSL:"
curl --version | grep -Ei "OpenSSL|GnuTLS" || true

echo
echo "PSL:"
curl --version | grep -i "libpsl" || true

echo
echo "[OK] cURL operacional."