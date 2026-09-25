# Build do EclipseNova OS

## Estado atual
O repositório contém infraestrutura e scripts. Isso não equivale a uma build validada.

## Host
Use Linux x86_64. O host precisa cumprir os requisitos do LFS 13.1-systemd.

## Ordem de alto nível
1. Validar o host.
2. Preparar `/mnt/lfs`.
3. Baixar e verificar fontes oficiais.
4. Construir toolchain temporária.
5. Entrar no chroot.
6. Construir o sistema LFS final.
7. Instalar apenas os componentes BLFS selecionados.
8. Reconstruir componentes que precisam de PAM.
9. Configurar kernel, firmware, rede, firewall e boot.
10. Executar `177-final-system-audit.sh`.
11. Preparar rootfs.
12. Criar initramfs live.
13. Criar ISO.
14. Testar em QEMU antes de gravar em USB ou instalar em hardware.

## Regra
Nunca execute em lote scripts ainda não auditados. Pare no primeiro erro e corrija a causa.
