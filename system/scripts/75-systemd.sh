#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/systemd-261.2"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Systemd 261.2"
echo "======================================"

sed -e 's/GROUP="render"/GROUP="video"/' \
    -e 's/GROUP="sgx", //' \
    -i rules.d/50-udev-default.rules.in

rm -rf build
mkdir -p build
cd build

meson setup .. \
    --prefix=/usr \
    --buildtype=release \
    -D default-dnssec=no \
    -D firstboot=false \
    -D install-tests=false \
    -D ldconfig=false \
    -D sysusers=false \
    -D rpmmacrosdir=no \
    -D homed=disabled \
    -D man=disabled \
    -D mode=release \
    -D pamconfdir=no \
    -D dev-kvm-mode=0660 \
    -D nobody-group=nogroup \
    -D sysupdate=disabled \
    -D ukify=disabled \
    -D docdir=/usr/share/doc/systemd-261.2

ninja -j1

echo 'NAME="SolarNexum OS"' > /etc/os-release

echo "[INFO] Executando testes..."
unshare -m ninja test

ninja install

tar -xf ../../systemd-man-pages-261.2.tar.xz \
    --no-same-owner \
    --strip-components=1 \
    -C /usr/share/man

systemd-machine-id-setup
systemctl preset-all

echo
echo "[OK] Systemd 261.2 instalado."