#!/bin/zsh

##### Environment Variables
### XDG DIRECTORIES
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
### HOME CLEANUP
export ZDOTDIR="${XDG_CONFIG_HOME}"/zsh
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}"/npm/npmrc
export CARGO_HOME="$XDG_DATA_HOME"/cargo
### MISC
export PATH=${XDG_DATA_HOME}/npm/bin:~/.local/bin:$PATH
export LESSHISTFILE="-"
export EDITOR='nvim'
export MANPAGER='nvim +Man!'

##### SSH
eval $(keychain --absolute --dir "${XDG_RUNTIME_DIR}"/keychain --noask --clear --eval id_ed25519)
