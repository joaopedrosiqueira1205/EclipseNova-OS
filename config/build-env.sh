#!/usr/bin/env bash

# ==========================================
# SolarNexum OS - Build Environment
# ==========================================

# Local onde o SolarNexum sera construido
export LFS="${LFS:-/mnt/lfs}"

# Arquitetura da cross-toolchain
export LFS_TGT="$(uname -m)-lfs-linux-gnu"

# Notebook alvo possui 4 GB de RAM.
# Usamos 1 processo para reduzir o consumo.
export BUILD_JOBS="${BUILD_JOBS:-1}"

# Diretorios principais
export SOLARNEXUM_SOURCES="$LFS/sources"
export SOLARNEXUM_TOOLS="$LFS/tools"

# Priorizar a toolchain temporaria do SolarNexum.
# Isso permite encontrar comandos como:
# x86_64-lfs-linux-gnu-gcc
export PATH="$LFS/tools/bin:/usr/bin:/bin"

# Evitar configuracoes externas interferindo no build
unset CFLAGS
unset CXXFLAGS

# Configuracao padrao usada por varios pacotes
export CONFIG_SITE="$LFS/usr/share/config.site"

# Compilacao conservadora para o notebook de 4 GB
export MAKEFLAGS="-j$BUILD_JOBS"

echo "[SolarNexum] Ambiente de build carregado"
echo "LFS:     $LFS"
echo "Target:  $LFS_TGT"
echo "Jobs:    $BUILD_JOBS"
echo "PATH:    $PATH"