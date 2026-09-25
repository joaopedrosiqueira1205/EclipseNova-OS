#!/usr/bin/env bash
set -euo pipefail
ISO="${1:-build/EclipseNova-0.1-x86_64.iso}"
command -v qemu-system-x86_64 >/dev/null || { echo "QEMU nao encontrado."; exit 1; }
[ -f "$ISO" ] || { echo "ISO nao encontrada: $ISO"; exit 1; }
qemu-system-x86_64 -m 2048 -smp 2 -enable-kvm -cdrom "$ISO" -boot d
