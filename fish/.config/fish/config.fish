# Run on login (like .zprofile)
if status is-login
    # https://superuser.com/questions/1727591/how-to-run-ssh-agent-in-fish-shell
    keychain --noask --eval $SSH_KEYS_TO_AUTOLOAD --absolute --dir "$XDG_RUNTIME_DIR"/keychain | source
end

if not status is-interactive
    return 0
end

# Remove the gretting message.
set -U fish_greeting

# Disable History
set -g fish_history ""

### Aliases
alias v="nvim"

alias pacman="pacman --color=auto"
alias yay="yay --color=auto"

alias cp="cp -r"
alias mv="mv -i"

alias ls="exa"
alias la="exa -a"
alias ll="exa -l"
alias lal="exa -al"
alias tree="exa -T"

### Variables
set -x EDITOR nvim
set -x MANPAGER "nvim +Man!"
# XDG DIRECTORIES
set -x XDG_CONFIG_HOME "$HOME/.config"
set -x XDG_CACHE_HOME "$HOME/.cache"
set -x XDG_DATA_HOME "$HOME/.local/share"
set -x XDG_STATE_HOME "$HOME/.local/state"
# Wayland
set -x SDL_VIDEODRIVER wayland
# ripgrep
set -x RIPGREP_CONFIG_PATH "$XDG_CONFIG_HOME/ripgrep/config"
# Javascript
set -x NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"
set -x NODE_REPL_HISTORY "$XDG_DATA_HOME/node_repl_history"
set -x PNPM_HOME "$XDG_DATA_HOME/pnpm"
# Rust
set -x CARGO_HOME "$XDG_DATA_HOME/cargo"
# Docker
set -x DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
# Python
set -x RUFF_CACHE_DIR "$XDG_CACHE_HOME/ruff"
set -x PYTHONSTARTUP "$XDG_CONFIG_HOME/python/startup.py"
# VS Code
set -x VSCODE_PORTABLE "$XDG_DATA_HOME/vscode"
# Fzf
set -x FZF_DEFAULT_OPTS "--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 --color=selected-bg:#45475a --multi"

fish_add_path -P "$XDG_DATA_HOME/npm/bin"
fish_add_path -P "$PNPM_HOME"

zoxide init --cmd cd fish |  source
starship init fish | source
