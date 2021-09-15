#!/bin/zsh
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
### MISC
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export LESSHISTFILE="-"
export EDITOR='nvim'
export MANPAGER='nvim +Man!'
#export UNCRUSTIFY_CONFIG="$XDG_CONFIG_HOME"/uncrustify/uncrustify.cfg
