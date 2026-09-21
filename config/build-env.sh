#!/usr/bin/env bash

# ==========================================
# SolarNexum OS - Build Environment
# LFS 13.1-systemd
# ==========================================

# Diretorio onde o SolarNexum sera construido
export LFS="${LFS:-/mnt/lfs}"

# Arquitetura da cross-toolchain
export LFS_TGT="$(uname -m)-lfs-linux-gnu"

# Compilacao conservadora para notebook com 4 GB RAM
export BUILD_JOBS="${BUILD_JOBS:-1}"
export MAKEFLAGS="-j$BUILD_JOBS"

# Diretorios principais
export SOLARNEXUM_SOURCES="$LFS/sources"
export SOLARNEXUM_TOOLS="$LFS/tools"

# Ambiente previsivel para a compilacao
export LC_ALL=POSIX

# Toolchain temporaria primeiro no PATH
export PATH="$LFS/tools/bin:/usr/bin:/bin"

# Impedir configuracoes do sistema hospedeiro
# de interferirem na compilacao
unset CFLAGS
unset CXXFLAGS

# Config.site usado durante as etapas temporarias
export CONFIG_SITE="$LFS/usr/share/config.site"

echo "[SolarNexum] Ambiente de build carregado"
echo "LFS:    $LFS"
echo "Target: $LFS_TGT"
echo "Jobs:   $BUILD_JOBS"