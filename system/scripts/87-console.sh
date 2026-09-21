#!/usr/bin/env bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

echo "======================================"
echo " SolarNexum OS - Console"
echo "======================================"

cat > /etc/vconsole.conf << "EOF"
KEYMAP=br-abnt2
FONT=Lat2-Terminus16
EOF

echo
echo "[OK] Console configurado."
echo "[INFO] Teclado: Brasileiro ABNT2"
echo "[INFO] Fonte: Lat2-Terminus16"