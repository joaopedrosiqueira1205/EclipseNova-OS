# Independência do EclipseNova OS

"Independente" neste projeto significa:

- não remasterizar uma ISO de Debian/Ubuntu/Arch;
- não depender do gerenciador de pacotes binários de outra distribuição;
- construir a base do sistema a partir de fontes;
- manter identidade, configuração, build e release próprios;
- usar LFS/BLFS como documentação de construção, não como uma distribuição binária instalada por baixo.

O kernel Linux, GNU, systemd, OpenSSL e outros projetos continuam sendo componentes upstream. Reescrever esses componentes do zero não é objetivo do EclipseNova.
