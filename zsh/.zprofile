#!/bin/zsh
##### Environment Variables
### XDG DIRECTORIES
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
if test -z "${XDG_RUNTIME_DIR}"; then
    export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
    if ! test -d "${XDG_RUNTIME_DIR}"; then
        mkdir "${XDG_RUNTIME_DIR}"
        chmod 0700 "${XDG_RUNTIME_DIR}"
    fi
fi
### HOME CLEANUP
export ZDOTDIR="${XDG_CONFIG_HOME}"/zsh
export XAUTHORITY="${XDG_RUNTIME_DIR}"/Xauthority
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}"/npm/npmrc
### MISC
export PATH=${XDG_DATA_HOME}/npm/bin:$PATH
export LESSHISTFILE="-"
export EDITOR='nvim'
export MANPAGER='nvim +Man!'
##### SSH
eval $(keychain --absolute --dir "${XDG_RUNTIME_DIR}"/keychain --noask --clear --eval id_ed25519)
