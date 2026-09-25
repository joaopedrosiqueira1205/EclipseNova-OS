#!/usr/bin/env bash
set -euo pipefail
ROOT="${1:-/tmp/eclipsenova-rootfs}"
OUT="${2:-build}"
mkdir -p "$OUT"
[ -d "$ROOT" ] || { echo "ERRO: rootfs inexistente"; exit 1; }
tar --xattrs --acls -C "$ROOT" -cJf "$OUT/eclipsenova-rootfs.tar.xz" .
sha256sum "$OUT/eclipsenova-rootfs.tar.xz" > "$OUT/SHA256SUMS"
echo "Release rootfs criada em $OUT"
