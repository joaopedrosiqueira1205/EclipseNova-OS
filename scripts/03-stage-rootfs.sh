#!/usr/bin/env bash
set -euo pipefail

# EclipseNova OS - Preparacao segura do rootfs

if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <origem-do-EclipseNova> <destino-do-rootfs>"
    echo "Exemplo: $0 /mnt/lfs /tmp/eclipsenova-rootfs"
    exit 1
fi

[ "$(id -u)" -eq 0 ] || {
    echo "ERRO: execute como root no ambiente Linux de compilacao."
    exit 1
}

command -v realpath >/dev/null || {
    echo "ERRO: comando realpath nao encontrado."
    exit 1
}

SRC="$(realpath -e -- "$1")"
DST="$(realpath -m -- "$2")"

[ -d "$SRC" ] || {
    echo "ERRO: origem inexistente: $SRC"
    exit 1
}

# Impedir uso da raiz do sistema e caminhos iguais.
if [ "$SRC" = "/" ] || [ "$DST" = "/" ] || [ "$SRC" = "$DST" ]; then
    echo "ERRO: origem ou destino inseguro."
    exit 1
fi

# O destino nao pode estar dentro da origem.
case "$DST/" in
    "$SRC/"*)
        echo "ERRO: o destino nao pode ficar dentro da origem."
        exit 1
        ;;
esac

# A origem nao pode estar dentro do destino.
case "$SRC/" in
    "$DST/"*)
        echo "ERRO: a origem nao pode ficar dentro do destino."
        exit 1
        ;;
esac

# Nunca apagar ou sobrescrever um destino existente.
if [ -e "$DST" ] || [ -L "$DST" ]; then
    echo "ERRO: o destino ja existe: $DST"
    echo "Escolha um diretorio novo."
    exit 1
fi

# Conferir se a origem tem a estrutura basica esperada.
if [ ! -d "$SRC/usr" ] || [ ! -d "$SRC/etc" ]; then
    echo "ERRO: a origem nao parece conter um sistema Linux preparado."
    exit 1
fi

mkdir -p -- "$DST"

for d in bin boot etc home lib lib64 opt root run sbin srv usr var; do
    if [ -e "$SRC/$d" ] || [ -L "$SRC/$d" ]; then
        cp -a -- "$SRC/$d" "$DST/"
    fi
done

mkdir -p -- "$DST"/{dev,proc,sys,tmp,mnt}
chmod 1777 "$DST/tmp"

echo "[OK] Rootfs preparado em: $DST"