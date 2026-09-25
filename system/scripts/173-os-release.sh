#!/usr/bin/env bash
set -euo pipefail
cat > /etc/os-release <<'EOF'
NAME="EclipseNova OS"
PRETTY_NAME="EclipseNova OS 0.1"
ID=eclipsenova
ID_LIKE=lfs
VERSION_ID="0.1"
VERSION="0.1 (Nova)"
VERSION_CODENAME=nova
RELEASE_TYPE=development
EOF
echo "13.1-systemd" > /etc/lfs-release
cat > /etc/lsb-release <<'EOF'
DISTRIB_ID="EclipseNova"
DISTRIB_RELEASE="0.1"
DISTRIB_CODENAME="nova"
DISTRIB_DESCRIPTION="EclipseNova OS 0.1"
EOF
