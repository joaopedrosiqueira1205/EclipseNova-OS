#!/usr/bin/env bash
set -euo pipefail
ROOTFS="${1:-/tmp/eclipsenova-rootfs}"
OUT="${2:-/tmp/eclipsenova-iso/boot/initramfs.img}"
[ "$(id -u)" -eq 0 ] || { echo "Execute como root."; exit 1; }
command -v dracut >/dev/null || { echo "dracut necessario no host para esta estrategia."; exit 1; }
KVER="${KVER:-$(ls "$ROOTFS/lib/modules" 2>/dev/null | sort -V | tail -1)}"
[ -n "$KVER" ] || { echo "Kernel modules nao encontrados."; exit 1; }
mkdir -p "$(dirname "$OUT")"
dracut --force --kver "$KVER" "$OUT"
echo "initramfs: $OUT"
