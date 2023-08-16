source ~/.zsh/init.zsh

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
ZSH_THEME="powerlevel10k/powerlevel10k"
[ -f ~/.p10k.zsh ] && source ~/.p10k.zsh

export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode auto
plugins=(git zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

alias tx='tmux'
alias tf='terraform'
alias tfw="f() { terraform workspace list | sed 's/* //' | tr -d ' ' | fzf -1 -q \"\${1}\" | xargs terraform workspace select; }; f"
alias sniff="f() { ssh ansible@\$1 \"sudo /usr/sbin/tcpdump -U -w - -i any not port 22 \$2\" | termshark -i - }; f"
alias kctx="f() { kubectl config get-contexts -o name | fzf -1 -q \"\${1}\" | xargs kubectl config use-context }; f"
alias helm-drift="f() { helm get manifest -n api \$1 | kubectl diff -n api -f - }; f"
alias act="act \
  --container-architecture linux/amd64 \
  -P self-hosted=nektos/act-environments-ubuntu:18.04 \
  -P github.com/intento/intento-github-actions=~andrewozhegov/dev/intento/intento-github-actions \
  --env-file ~/.config/act/env \
  --var-file ~/.config/act/vars \
  --secret-file ~/.config/act/secrets"

export JAVA_HOME="$(/usr/libexec/java_home)"

zsh_add_path "/opt/homebrew/bin"
zsh_add_path "/opt/homebrew/sbin"
zsh_add_path "/opt/homebrew/opt/openjdk/bin"
zsh_add_path "$JAVA_HOME"
zsh_add_path "$HOME/dev/bin"
zsh_add_path "$HOME/.local/bin"
zsh_add_path "/opt/homebrew/opt/gnu-sed/libexec/gnubin"

zsh_add_config fzf-zsh-completion
zsh_add_config direnv

export FX_THEME=3
export FX_SHOW_SIZE=true

export TMUX_PLUGIN_MANAGER_PATH=$HOME/.config/tmux/plugins/

eval "$(direnv hook zsh)"
eval "$(aws-ssm-get complete)"
eval "$(aws-r53-get complete)"

source <(kubectl completion zsh)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

