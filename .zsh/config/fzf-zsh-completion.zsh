zsh_add_plugin "https://github.com/lincheney/fzf-tab-completion.git"

source $ZSH_PLUGIN_DIR/fzf-tab-completion/zsh/fzf-zsh-completion.sh
bindkey '^I' fzf_completion
