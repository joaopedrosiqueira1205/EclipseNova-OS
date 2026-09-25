#!/usr/bin/env bash
set -euo pipefail
echo "EclipseNova: verificacao systemd + PAM"
if [ -e /usr/lib/security/pam_systemd.so ]; then
  echo "[OK] pam_systemd.so presente"
else
  echo "[PENDENTE] reconstruir systemd 261.2 apos Linux-PAM 1.7.2, seguindo BLFS 13.1."
  exit 2
fi
