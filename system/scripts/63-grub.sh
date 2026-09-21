#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/grub-2.14"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - GRUB 2.14"
echo " Plataforma: x86_64 UEFI"
echo "======================================"

# GRUB nao deve receber flags de otimizacao personalizadas.
unset CFLAGS CPPFLAGS CXXFLAGS LDFLAGS

# Corrige um problema introduzido no GRUB 2.14.
sed 's/--image-base/--nonexist-linker-option/' -i configure

./configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --target=x86_64 \
    --with-platform=efi \
    --disable-efiemu \
    --disable-werror

make -j1
make install

echo
echo "[OK] GRUB 2.14 para x86_64 UEFI instalado."
echo "[INFO] Nenhum bootloader foi gravado no disco."