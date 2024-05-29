#!/bin/zsh

##### Environment Variables

### XDG DIRECTORIES
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

### Home Cleanup
# Zsh
export ZDOTDIR="${XDG_CONFIG_HOME}"/zsh
# Javascript
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}"/npm/npmrc
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
# Rust
export CARGO_HOME="${XDG_DATA_HOME}"/cargo
# Java
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
# Julia
export JULIA_DEPOT_PATH="$XDG_DATA_HOME/julia:$JULIA_DEPOT_PATH"
# Python
export RUFF_CACHE_DIR=$XDG_CACHE_HOME/ruff
export MYPY_CACHE_DIR="${XDG_CACHE_HOME}"/mypy
export NLTK_DATA="${XDG_CACHE_HOME}/nltk"
export PYTHONSTARTUP="${XDG_CONFIG_HOME}"/python/startup.py
# Ruby
export GEM_HOME="${XDG_DATA_HOME}"/gems
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle 
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle 
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle

### MISC
export PATH="${XDG_DATA_HOME}/npm/bin:${PATH}"
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/ripgrep/config"
export LESSHISTFILE="-"
export EDITOR='nvim'
export MANPAGER='nvim +Man!'

##### SSH
pgrep ssh-agent || eval $(ssh-agent)
