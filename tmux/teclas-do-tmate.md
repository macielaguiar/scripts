# Teclas Ctrl+\<setas\> e Shift+\<setas\> no Tmate

## O problema:

Com as mesmas configurações, as combinações de teclas envolvendo `Ctrl+<setas>` e `Shift+<setas>` não funcionavam no `tmate`, mas funcionavam no `tmux`. Isso me impedia de fazer seleções de texto no GNU Nano ou de utilizar a movimentação rápida pelas palavras de uma linha de comando.

## A solução:

Embora seja desnecessário para o Tmux, o Tmate só se comporta como esperado com a linha abaixo na configuração (no meu caso, um link para `.tmux.conf`, mas pode ser um `.tmate.conf` independente):

```
set-window-option -g xterm-keys on
```

[Minha configuração atual](https://codeberg.org/blau_araujo/tmux-videos/src/branch/main/conf/tmux.conf)