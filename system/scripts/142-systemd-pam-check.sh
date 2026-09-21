#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - systemd/PAM Check"
echo "======================================"

if [ -e /usr/lib/security/pam_systemd.so ]; then
    echo "[OK] pam_systemd presente."
else
    echo "[PENDENTE] systemd precisa ser reconstruido"
    echo "com suporte ao Linux-PAM."
fi

if command -v loginctl >/dev/null 2>&1; then
    echo "[OK] loginctl encontrado."
else
    echo "[ERRO] loginctl nao encontrado."
fi