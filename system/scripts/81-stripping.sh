#!/usr/bin/env bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

echo "======================================"
echo " SolarNexum OS - Stripping"
echo "======================================"

echo
echo "[AVISO]"
echo "Esta etapa remove simbolos de depuracao."
echo "Execute somente depois de criar um backup"
echo "do sistema base."
echo

read -r -p "Digite STRIP para continuar: " CONFIRM

if [ "$CONFIRM" != "STRIP" ]; then
    echo "[CANCELADO] Nenhum arquivo foi alterado."
    exit 0
fi

save_usrlib="$(cd /usr/lib; ls ld-linux*[^g])
              libc.so.6
              libthread_db.so.1
              libquadmath.so.0.0.0
              libstdc++.so.6.0.34
              libitm.so.1.0.0
              libatomic.so.1.2.0"

cd /usr/lib

for LIB in $save_usrlib; do
    objcopy --only-keep-debug --compress-debug-sections=zstd \
        "$LIB" "$LIB.dbg"

    cp "$LIB" /tmp/"$LIB"

    strip --strip-unneeded "$LIB"

    objcopy --add-gnu-debuglink="$LIB.dbg" "$LIB"
done

online_usrbin="bash find strip"
online_usrlib="libbfd-2.47.so
              libsframe.so.2.0.0
              libhistory.so.8.3
              libncursesw.so.6.6
              libm.so.6
              libreadline.so.8.3
              libz.so.1.3.2
              libzstd.so.1.5.7
              liblzma.so.5.8.3
              libcrypto.so.4
              libssl.so.4"

for BIN in $online_usrbin; do
    cp /usr/bin/"$BIN" /tmp/"$BIN"
done

for LIB in $online_usrlib; do
    cp /usr/lib/"$LIB" /tmp/"$LIB"
done

(
    exec 0</dev/null
    exec 1>/tmp/strip.log
    exec 2>&1

    set -x

    strip --strip-debug /usr/lib/*.a

    strip --strip-unneeded \
        /usr/bin/* \
        /usr/sbin/* \
        /usr/lib/*.so* \
        /usr/libexec/* 2>/dev/null || true
)

echo
echo "[OK] Stripping concluido."
echo "[INFO] Verifique /tmp/strip.log."