# Auditoria obrigatória antes do primeiro build

O projeto anterior foi criado rapidamente em muitos scripts. Antes da execução real:

- remover todas as referências `SolarNexum`, `solarnexum` e `SOLARNEXUM`;
- unificar `BUILD_JOBS=1` para a máquina de pouca memória;
- conferir cada versão e patch com LFS 13.1-systemd / BLFS 13.1-systemd;
- corrigir a ordem PAM -> Shadow/systemd rebuild -> Polkit -> NetworkManager;
- conferir dependências reais de wpa_supplicant e NetworkManager;
- conferir a estratégia de firewall (iptables/nftables) e escolher uma;
- revisar kernel para o Lenovo IdeaPad S145-15IIL e também um perfil x86_64 genérico;
- não executar scripts de stripping/cleanup antes de validar o sistema;
- não instalar GRUB em disco real até identificar corretamente ESP e disco alvo;
- validar initramfs/live boot em VM;
- só depois gerar a ISO de release.

O script `scripts/01-audit-repository.sh` ajuda a localizar inconsistências mecânicas, mas não substitui a revisão técnica.
