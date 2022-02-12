# .zshrc
HISTFILE=
HISTSIZE=127
SAVEHIST=0
bindkey -e
# Tab complete
autoload -Uz compinit
zmodload zsh/complist
compinit -d "${XDG_CACHE_HOME}"/zsh/zcompdump-"${ZSH_VERSION}"
_comp_options+=(globdots)		# Include hidden files.
### Enable colors and change prompt
autoload -U colors && colors
PS1="%{$fg[magenta]%}%~ %{$reset_color%}$ "
### Aliases
alias ls='ls --color=auto -v'
alias x='dbus-run-session startx "$XDG_CONFIG_HOME/X11/xinitrc"'
alias cp='cp -r'
alias mv='mv -i'
alias v='nvim'
# config files
alias cwm='nvim -p ~/.config/i3/config'
alias cv='nvim -p ~/.config/nvim/{init.vim,lua/*}'
### Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
