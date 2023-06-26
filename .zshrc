
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"

[ -f ~/.p10k.zsh ] && source ~/.p10k.zsh


export ZSH="$HOME/.oh-my-zsh"

XDG_CONFIG_HOME="$HOME/.config"
XDG_CACHE_HOME="$HOME/.cache"

zstyle ':omz:update' mode auto

plugins=(git dotbare zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh


alias tx='tmux'
alias tf='terraform'
alias tfw="f() { terraform workspace list | sed 's/* //' | tr -d ' ' | fzf -q \${1} -1 | xargs terraform workspace select; }; f"
alias sniff="f() { ssh ansible@\$1 \"sudo /usr/sbin/tcpdump -U -w - -i any not port 22 \$2\" | termshark -i - }; f"
alias kctx="f() { kubectl config get-contexts -o name | fzf -1 -q \"\${1}\" | xargs kubectl config use-context }; f"
alias helm-drift="f() { helm get manifest -n api \$1 | kubectl diff -n api -f - }; f"

export JAVA_HOME="$(/usr/libexec/java_home)"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$JAVA_HOME:$PATH"
export PATH="$HOME/dev/bin:$PATH"
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"


export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"

if which pyenv-virtualenv-init > /dev/null; then
   eval "$(pyenv init -)";
   eval "$(pyenv virtualenv-init -)"
fi

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export PYENV_VIRTUALENV_DISABLE_PROMPT=1


export FX_THEME=3
export FX_SHOW_SIZE=true


export TMUX_PLUGIN_MANAGER_PATH=$HOME/.config/tmux/plugins/

eval "$(direnv hook zsh)"
eval "$(aws-get-ssm complete)"
eval "$(aws-get-r53 complete)"

_dotbare_completion_cmd

source <(kubectl completion zsh)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

