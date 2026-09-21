#!/usr/bin/env bash
set -euo pipefail

VERSION="2.12"
SRC="/sources/wpa_supplicant-${VERSION}/wpa_supplicant"

echo "======================================"
echo " EclipseNova OS - wpa_supplicant"
echo "======================================"

if [ ! -d "$SRC" ]; then
    echo "[ERRO] Fonte nao encontrada:"
    echo "$SRC"
    exit 1
fi

cd "$SRC"

cat > .config << "EOF"
CONFIG_DRIVER_NL80211=y
CONFIG_LIBNL32=y
CONFIG_CTRL_IFACE=y
CONFIG_BACKEND=file
CONFIG_IEEE8021X_EAPOL=y
CONFIG_EAP_MD5=y
CONFIG_EAP_MSCHAPV2=y
CONFIG_EAP_TLS=y
CONFIG_EAP_PEAP=y
CONFIG_EAP_TTLS=y
CONFIG_WPS=y
CONFIG_DBUS=y
CONFIG_READLINE=y
EOF

make -j1

install -v -m755 wpa_cli wpa_supplicant /usr/sbin/
install -v -m755 wpa_passphrase /usr/bin/

echo "[OK] wpa_supplicant instalado."