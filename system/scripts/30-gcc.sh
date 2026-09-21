#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/gcc-16.2.0"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - GCC 16.2.0"
echo "======================================"

case $(uname -m) in
    x86_64)
        sed -e '/m64=/s/lib64/lib/' \
            -i.orig gcc/config/i386/t-linux64
    ;;
esac

rm -rf build
mkdir -v build
cd build

../configure \
    --prefix=/usr \
    LD=ld \
    --enable-languages=c,c++ \
    --enable-default-pie \
    --enable-default-ssp \
    --enable-host-pie \
    --enable-targets=all \
    --disable-multilib \
    --disable-bootstrap \
    --disable-fixincludes \
    --with-system-zlib

make -j1

echo
echo "[IMPORTANTE] Executando testes do GCC..."

ulimit -s -H unlimited
chown -R tester .
su tester -c "PATH=$PATH make -k check"

echo
echo "[INFO] Resumo dos testes:"
../contrib/test_summary

make install

chown -v -R root:root \
    /usr/lib/gcc/$(gcc -dumpmachine)/16.2.0/include{,-fixed}

ln -svr /usr/bin/cpp /usr/lib
ln -sv gcc.1 /usr/share/man/man1/cc.1

ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/16.2.0/liblto_plugin.so \
    /usr/lib/bfd-plugins/

echo
echo "[INFO] Verificando compilador definitivo..."

echo 'int main(){}' > dummy.c
cc dummy.c -v -Wl,--verbose &> dummy.log

readelf -l a.out | grep ': /lib'

grep -E -o '/usr/lib.*/S?crt[1in].*succeeded' dummy.log
grep -B4 '^ /usr/include' dummy.log
grep 'SEARCH.*/usr/lib' dummy.log | sed 's|; |\n|g'
grep "/lib.*/libc.so.6 " dummy.log
grep found dummy.log

rm -v a.out dummy.c dummy.log

mkdir -pv /usr/share/gdb/auto-load/usr/lib

if compgen -G "/usr/lib/*gdb.py" > /dev/null; then
    mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib
fi

echo
echo "[OK] GCC 16.2.0 instalado."