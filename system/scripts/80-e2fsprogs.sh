#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/e2fsprogs-1.47.4"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - E2fsprogs 1.47.4"
echo "======================================"

rm -rf build
mkdir -v build
cd build

../configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --enable-elf-shlibs \
    --disable-libblkid \
    --disable-libuuid \
    --disable-uuidd \
    --disable-fsck

make -j1

echo "[INFO] Executando testes..."
make check

make install

rm -fv /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a

gunzip -v /usr/share/info/libext2fs.info.gz

install-info \
    --dir-file=/usr/share/info/dir \
    /usr/share/info/libext2fs.info

echo
echo "[OK] E2fsprogs 1.47.4 instalado."