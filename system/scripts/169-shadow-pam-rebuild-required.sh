#!/usr/bin/env bash
set -euo pipefail
echo "EclipseNova: Shadow/PAM"
if [ -d /etc/pam.d ] && [ -f /etc/pam.d/other ]; then
  echo "[INFO] PAM existe. Audite/reconstrua Shadow conforme BLFS 13.1 antes da imagem final."
else
  echo "[PENDENTE] PAM ainda nao configurado."; exit 2
fi
