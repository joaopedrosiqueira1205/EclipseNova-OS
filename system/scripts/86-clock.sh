#!/usr/bin/env bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

echo "======================================"
echo " SolarNexum OS - Clock"
echo "======================================"

ln -sfv /usr/share/zoneinfo/America/Sao_Paulo \
    /etc/localtime

cat > /etc/adjtime << "EOF"
0.0 0 0.0
0
UTC
EOF

echo
echo "[OK] Fuso horario configurado."
echo "[OK] Relogio de hardware configurado para UTC."