#!/usr/bin/env bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

echo "======================================"
echo " SolarNexum OS - Systemd Config"
echo "======================================"

mkdir -pv /etc/systemd/system

systemctl set-default multi-user.target

systemctl enable systemd-timesyncd.service

mkdir -pv /etc/systemd/journald.conf.d

cat > /etc/systemd/journald.conf.d/solarnexum.conf << "EOF"
[Journal]
Storage=persistent
SystemMaxUse=100M
EOF

echo
echo "[OK] Systemd configurado."
echo "[INFO] Boot padrao: multi-user.target"
echo "[INFO] Sincronizacao de horario habilitada."
echo "[INFO] Journal persistente limitado a 100 MB."