#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/sqlite-autoconf-3530400"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - SQLite 3.53.4"
echo "======================================"

python3 -m zipfile -e ../sqlite-doc-3530400.zip .

./configure \
    --prefix=/usr \
    --disable-static \
    --enable-fts{4,5} \
    CPPFLAGS="-D SQLITE_ENABLE_COLUMN_METADATA=1 \
              -D SQLITE_ENABLE_UNLOCK_NOTIFY=1 \
              -D SQLITE_ENABLE_DBSTAT_VTAB=1 \
              -D SQLITE_SECURE_DELETE=1"

make -j1 LDFLAGS.rpath=""

make install

cp -v -R sqlite-doc-3530400 \
    -T /usr/share/doc/sqlite-3.53.4

echo
echo "[OK] SQLite 3.53.4 instalado."