#!/usr/bin/env bash
set -euo pipefail
echo "eclipsenova" > /etc/hostname
cat > /etc/hosts <<'EOF'
127.0.0.1 localhost
127.0.1.1 eclipsenova
::1       localhost ip6-localhost ip6-loopback
EOF
echo "[OK] identidade EclipseNova aplicada."
