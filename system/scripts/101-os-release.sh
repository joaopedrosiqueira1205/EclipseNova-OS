#!/usr/bin/env bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute como root."
    exit 1
fi

echo "======================================"
echo " EclipseNova OS - System Identity"
echo "======================================"

cat > /etc/os-release << "EOF"
NAME="EclipseNova OS"
VERSION="0.1"
ID=eclipsenova
ID_LIKE=lfs
PRETTY_NAME="EclipseNova OS 0.1"
VERSION_ID="0.1"
VERSION_CODENAME="nova"
RELEASE_TYPE="development"
EOF

cat > /etc/lsb-release << "EOF"
DISTRIB_ID="EclipseNova"
DISTRIB_RELEASE="0.1"
DISTRIB_CODENAME="nova"
DISTRIB_DESCRIPTION="EclipseNova OS"
EOF

echo "13.1-systemd" > /etc/lfs-release

echo
echo "[OK] Sistema identificado como:"
grep PRETTY_NAME /etc/os-release