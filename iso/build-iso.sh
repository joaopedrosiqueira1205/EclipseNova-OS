#!/usr/bin/env bash
set -euo pipefail
ROOTFS="${1:-/tmp/eclipsenova-rootfs}"
WORK="${2:-/tmp/eclipsenova-iso}"
OUT="${3:-build/EclipseNova-0.1-x86_64.iso}"

[ "$(id -u)" -eq 0 ] || { echo "Execute como root."; exit 1; }
for c in grub-mkrescue xorriso mksquashfs; do
  command -v "$c" >/dev/null || { echo "FALTA no host: $c"; exit 1; }
done
[ -d "$ROOTFS" ] || { echo "Rootfs ausente: $ROOTFS"; exit 1; }

rm -rf "$WORK"
mkdir -p "$WORK/boot/grub" "$(dirname "$OUT")"

KERNEL=$(find "$ROOTFS/boot" -maxdepth 1 -type f -name 'vmlinuz-*-eclipsenova' | sort -V | tail -1)
[ -n "$KERNEL" ] || { echo "Kernel EclipseNova nao encontrado."; exit 1; }
cp "$KERNEL" "$WORK/boot/vmlinuz"

mksquashfs "$ROOTFS" "$WORK/eclipsenova.squashfs" -comp xz -noappend

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cp "$SCRIPT_DIR/grub.cfg" "$WORK/boot/grub/grub.cfg"

if [ ! -f "$WORK/boot/initramfs.img" ]; then
  echo "ERRO: initramfs ausente."
  echo "Gere um initramfs compatível com o modo live antes de criar a ISO."
  exit 1
fi

grub-mkrescue -o "$OUT" "$WORK"
sha256sum "$OUT" > "${OUT}.sha256"
echo "ISO criada: $OUT"
