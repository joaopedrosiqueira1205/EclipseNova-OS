#!/usr/bin/env bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

ROOT_DEVICE="${ROOT_DEVICE:-}"
SWAP_DEVICE="${SWAP_DEVICE:-}"
ROOT_FS="${ROOT_FS:-ext4}"

echo "======================================"
echo " SolarNexum OS - fstab"
echo "======================================"

if [ -z "$ROOT_DEVICE" ]; then
    echo "[ERRO] ROOT_DEVICE nao foi definido."
    echo "Exemplo:"
    echo "ROOT_DEVICE=/dev/sdXY bash 93-fstab.sh"
    exit 1
fi

cat > /etc/fstab << EOF
# Begin /etc/fstab

# file system       mount-point  type    options   dump fsck
$ROOT_DEVICE        /            $ROOT_FS defaults  1    1
EOF

if [ -n "$SWAP_DEVICE" ]; then
    echo "$SWAP_DEVICE swap swap pri=1 0 0" >> /etc/fstab
fi

cat >> /etc/fstab << "EOF"

# End /etc/fstab
EOF

echo
echo "[OK] /etc/fstab criado:"
cat /etc/fstab