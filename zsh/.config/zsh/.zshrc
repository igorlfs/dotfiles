# .zshrc

### Basic
HISTFILE=
HISTSIZE=127
SAVEHIST=0
bindkey -e

### Tab complete
autoload -Uz compinit
zmodload zsh/complist
compinit -d "${XDG_CACHE_HOME}"/zsh/zcompdump-"${ZSH_VERSION}"
_comp_options+=(globdots)		# Include hidden files.

### Enable colors and change prompt
autoload -U colors && colors
PS1="%{$fg[magenta]%}%~ %{$reset_color%}$ "

### Aliases
alias ls='ls --color=auto -v'
alias s='pgrep -x sway || exec dbus-run-session sway'
alias cp='cp -r'
alias mv='mv -i'
alias n='nvim'
alias v='nvim -'
# config files
alias cwm='nvim -p ~/.config/sway/{config,config.d/*}'
alias cv='nvim -p ~/.config/nvim/{init.vim,lua/*/*}'

### Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
