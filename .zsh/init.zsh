XDG_CONFIG_HOME="$HOME/.config"
XDG_CACHE_HOME="$HOME/.cache"

ZSH_PLUGIN_DIR="$HOME/.zsh/plugin"
ZSH_FUNCTION_DIR="$HOME/.zsh/function"
ZSH_CONFIG_DIR="$HOME/.zsh/config"

function zsh_include {
  for file in $@; do
    source $file
  done
}

zsh_include $ZSH_FUNCTION_DIR/*
zsh_include $ZSH_CONFIG_DIR/*.auto.zsh
