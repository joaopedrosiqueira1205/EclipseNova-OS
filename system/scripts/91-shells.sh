#!/usr/bin/env bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

echo "======================================"
echo " SolarNexum OS - Shells"
echo "======================================"

cat > /etc/shells << "EOF"
/bin/sh
/bin/bash
EOF

echo
echo "[OK] Shells validos:"
cat /etc/shells