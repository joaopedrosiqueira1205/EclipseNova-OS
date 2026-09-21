#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - Network Polkit Rule"
echo "======================================"

mkdir -pv /usr/share/polkit-1/rules.d

cat > /usr/share/polkit-1/rules.d/org.freedesktop.NetworkManager.rules << "EOF"
polkit.addRule(function(action, subject) {
    if (action.id.indexOf("org.freedesktop.NetworkManager.") == 0 &&
        subject.isInGroup("netdev")) {
        return polkit.Result.YES;
    }
});
EOF

chmod 644 \
    /usr/share/polkit-1/rules.d/org.freedesktop.NetworkManager.rules

echo "[OK] Regra criada."