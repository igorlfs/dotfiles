# .zshrc
HISTFILE=
HISTSIZE=127
SAVEHIST=0
bindkey -v
# Tab complete
autoload -Uz compinit
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.
### Enable colors and change prompt
autoload -U colors && colors
PS1="%{$fg[magenta]%}%~ %{$reset_color%}$ "
### Aliases
# shortcuts for config files
alias czsh='nvim ~/.config/zsh/.zshrc'
alias cwm='nvim -p ~/.config/i3/config'
alias cv='nvim ~/.config/nvim/init.vim'
# coreutils
alias ls='ls --color=auto'
alias cp='cp -r'
alias mv='mv -i'
# misc
alias vim='nvim -p'
#alias ds='~/rand/scripts/sway-launch.sh'
alias up='sudo xbps-install -Su'
### Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
