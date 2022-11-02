#!/bin/zsh

##### Environment Variables
### XDG DIRECTORIES
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
### HOME CLEANUP
export ZDOTDIR="${XDG_CONFIG_HOME}"/zsh
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}"/npm/npmrc
export CARGO_HOME="${XDG_DATA_HOME}"/cargo
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
### MISC
export PATH=${XDG_DATA_HOME}/npm/bin:${PATH}
export LESSHISTFILE="-"
export EDITOR='nvim'
export MANPAGER='nvim +Man!'

##### SSH
eval $(ssh-agent)
