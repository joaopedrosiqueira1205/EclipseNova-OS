#!/usr/bin/env bash
set -euo pipefail
echo "EclipseNova OS installer skeleton"
echo
echo "Por seguranca, o instalador NAO particiona discos automaticamente."
echo "A instalacao destrutiva so sera habilitada depois de testes em VM."
echo
lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINTS
echo
echo "Use o processo manual documentado em docs/INSTALL.md enquanto o instalador nao for validado."
