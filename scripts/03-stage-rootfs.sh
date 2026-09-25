#!/usr/bin/env bash
set -euo pipefail
SRC="${1:-/}"
DST="${2:-/tmp/eclipsenova-rootfs}"
[ "$(id -u)" -eq 0 ] || { echo "Execute como root."; exit 1; }
rm -rf "$DST"
mkdir -p "$DST"
for d in bin boot etc home lib lib64 opt root run sbin srv usr var; do
  [ -e "$SRC/$d" ] && cp -a "$SRC/$d" "$DST/"
done
mkdir -p "$DST"/{dev,proc,sys,tmp,mnt}
chmod 1777 "$DST/tmp"
echo "Rootfs preparado em $DST"
