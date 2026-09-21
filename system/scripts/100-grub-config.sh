#!/usr/bin/env bash
set -euo pipefail

KERNEL="/boot/vmlinuz-7.1.8-eclipsenova"

ROOT_PARTUUID="${ROOT_PARTUUID:-}"
ROOT_FS_UUID="${ROOT_FS_UUID:-}"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute como root."
    exit 1
fi

if [ -z "$ROOT_PARTUUID" ] || [ -z "$ROOT_FS_UUID" ]; then
    echo "[ERRO] ROOT_PARTUUID e ROOT_FS_UUID precisam ser definidos."
    echo
    echo "Use no sistema real:"
    echo "lsblk -o UUID,PARTUUID,PATH,MOUNTPOINT"
    exit 1
fi

if [ ! -f "$KERNEL" ]; then
    echo "[ERRO] Kernel nao encontrado:"
    echo "$KERNEL"
    exit 1
fi

mkdir -pv /boot/grub

cat > /boot/grub/grub.cfg << EOF
# Begin /boot/grub/grub.cfg

set default=0
set timeout=5

insmod part_gpt
insmod ext2

search --set=root --fs-uuid $ROOT_FS_UUID

menuentry "EclipseNova OS" {
    linux /boot/vmlinuz-7.1.8-eclipsenova root=PARTUUID=$ROOT_PARTUUID ro
}

# End /boot/grub/grub.cfg
EOF

echo
echo "[OK] grub.cfg criado."