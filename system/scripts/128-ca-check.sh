#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - CA Check"
echo "======================================"

if [ -d /etc/ssl/certs ]; then
    echo "[OK] /etc/ssl/certs encontrado."
else
    echo "[PENDENTE] Certificados CA precisam ser configurados."
fi

if [ -f /etc/ssl/certs/ca-certificates.crt ] ||
   [ -f /etc/pki/tls/certs/ca-bundle.crt ]; then
    echo "[OK] CA bundle encontrado."
else
    echo "[AVISO] CA bundle nao encontrado."
fi