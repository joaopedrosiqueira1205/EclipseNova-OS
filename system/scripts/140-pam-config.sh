#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - PAM Configuration"
echo "======================================"

mkdir -pv /etc/pam.d

cat > /etc/pam.d/other << "EOF"
auth      required pam_unix.so
account   required pam_unix.so
password  required pam_unix.so
session   required pam_unix.so
EOF

chmod 644 /etc/pam.d/other

echo "[OK] Estrutura PAM preparada."