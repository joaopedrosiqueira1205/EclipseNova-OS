#!/usr/bin/env bash
set -euo pipefail
ISO="${1:-build/EclipseNova-0.1-x86_64.iso}"
[ -f "$ISO" ] || { echo "ERRO: ISO ausente"; exit 1; }
sha256sum "$ISO"
file "$ISO"
echo "Tamanho: $(du -h "$ISO" | cut -f1)"
