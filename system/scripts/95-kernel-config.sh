#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/linux-7.1.8"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Kernel Config"
echo "======================================"

if [ ! -f .config ]; then
    echo "[ERRO] .config nao encontrado."
    echo "Execute primeiro 94-kernel-prepare.sh."
    exit 1
fi

scripts/config --disable WERROR
scripts/config --enable PSI
scripts/config --disable PSI_DEFAULT_DISABLED
scripts/config --disable IKHEADERS

scripts/config --enable CGROUPS
scripts/config --enable MEMCG

scripts/config --enable RELOCATABLE
scripts/config --enable RANDOMIZE_BASE

scripts/config --enable STACKPROTECTOR
scripts/config --enable STACKPROTECTOR_STRONG

scripts/config --enable NET
scripts/config --enable INET
scripts/config --enable IPV6

scripts/config --disable UEVENT_HELPER
scripts/config --enable DEVTMPFS
scripts/config --enable DEVTMPFS_MOUNT

scripts/config --enable TTY
scripts/config --disable LEGACY_TIOCSTI

scripts/config --enable TMPFS
scripts/config --enable TMPFS_POSIX_ACL

scripts/config --enable EFI
scripts/config --enable EFI_STUB
scripts/config --enable EFI_PARTITION

scripts/config --enable VFAT_FS
scripts/config --enable EFIVAR_FS
scripts/config --enable NLS_CODEPAGE_437
scripts/config --enable NLS_ISO8859_1

scripts/config --enable PCI
scripts/config --enable PCI_MSI
scripts/config --enable X86_X2APIC

make olddefconfig

echo
echo "[OK] Requisitos basicos do kernel configurados."
echo
echo "[IMPORTANTE]"
echo "Drivers especificos do notebook ainda serao"
echo "auditados antes da compilacao real."