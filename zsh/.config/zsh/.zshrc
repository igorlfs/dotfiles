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
# lazy
alias h='pgrep -x Hyprland || exec dbus-run-session Hyprland'
alias v='nvim'
# utils
alias cp='cp -r'
alias mv='mv -i'
# colors
alias ls='exa'
alias la='exa -a'
alias ll='exa -l'
alias pacman='pacman --color=always'
alias nc='ncdu --color=dark --exclude-kernfs'

### Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
