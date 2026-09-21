#!/usr/bin/env bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

echo "======================================"
echo " SolarNexum OS - Locale"
echo "======================================"

if ! locale -a | grep -qi '^pt_BR\.utf8$'; then
    echo "[INFO] Criando locale pt_BR.UTF-8..."
    localedef -i pt_BR -f UTF-8 pt_BR.UTF-8
fi

cat > /etc/locale.conf << "EOF"
LANG=pt_BR.UTF-8
EOF

echo
echo "[OK] Locale configurado:"
cat /etc/locale.conf