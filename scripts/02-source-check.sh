#!/usr/bin/env bash
set -euo pipefail
SOURCES="${1:-/mnt/lfs/sources}"
echo "== EclipseNova source check =="
[ -d "$SOURCES" ] || { echo "ERRO: $SOURCES nao existe"; exit 1; }
count=$(find "$SOURCES" -maxdepth 1 -type f | wc -l)
echo "Arquivos-fonte presentes: $count"
echo "A verificacao criptografica deve usar os hashes oficiais LFS/BLFS antes da compilacao."
