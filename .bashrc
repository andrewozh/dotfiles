#
#      /$$                           /$$
#     | $$                          | $$
#     | $$$$$$$   /$$$$$$   /$$$$$$$| $$$$$$$   /$$$$$$   /$$$$$$$
#     | $$__  $$ |____  $$ /$$_____/| $$__  $$ /$$__  $$ /$$_____/
#     | $$  \ $$  /$$$$$$$|  $$$$$$ | $$  \ $$| $$  \__/| $$
#     | $$  | $$ /$$__  $$ \____  $$| $$  | $$| $$      | $$
#  /$$| $$$$$$$/|  $$$$$$$ /$$$$$$$/| $$  | $$| $$      |  $$$$$$$
# |__/|_______/  \_______/|_______/ |__/  |__/|__/       \_______/
#

# TODO:
#
# - XDG directories
# - keep zsh history
# - bash syntax highlighting

set -o vi

export VISUAL=nvim
export EDITOR=nvim
# export BROWSER="firefox"

export HISTSIZE=25000
export HISTCONTROL=ignorespace

#export JAVA_HOME="$(/usr/libexec/java_home)"
export TMUX_PLUGIN_MANAGER_PATH=$HOME/.config/tmux/plugins/

export FX_THEME=3
export FX_SHOW_SIZE=true

eval "$(/opt/homebrew/bin/brew shellenv)"

function add_path() { [ -d "$1" ] && export PATH="$1:$PATH" ; }
add_path "/opt/homebrew/opt/openjdk/bin"
add_path "$JAVA_HOME"
add_path "$HOME/dev/bin"
add_path "$HOME/Notes/bin"
add_path "$HOME/.local/bin"
add_path "/opt/homebrew/opt/gnu-sed/libexec/gnubin"
add_path "/opt/homebrew/opt/curl/bin"
add_path "/opt/homebrew/opt/postgresql@12/bin"
add_path "/Applications/Docker.app/Contents/Resources/bin"
export BASH_SILENCE_DEPRECATION_WARNING=1

# --------------------- Aliases ---------------------

alias tx='tmux'
alias tf='terraform'
alias tfw="f() { terraform workspace list | sed 's/* //' | tr -d ' ' | fzf -1 -q \"\${1}\" | xargs terraform workspace select ; }; f"
alias sniff="f() { ssh ansible@\$1 \"sudo /usr/sbin/tcpdump -U -w - -i any not port 22 \$2\" | termshark -i - ; }; f"
alias kctx="f() { kubectl config get-contexts -o name | fzf -1 -q \"\${1}\" | xargs kubectl config use-context ; }; f"
alias helm-drift="f() { helm get manifest -n api \$1 | kubectl diff -n api -f - ; }; f"
alias nvdiff="f() { nvim -d -c \"vnew\" -c \"diffsplit\" -c \"wincmd q\" -c \"wincmd h\" -c \"diffsplit\" -c \"wincmd q\" ; }; f"
alias act="act \
  --container-architecture linux/amd64 \
  -P self-hosted=nektos/act-environments-ubuntu:18.04 \
  -P k8s-runners=ghcr.io/actions/actions-runner:latest \
  --env-file ~/.config/act/env \
  --var-file ~/.config/act/vars \
  --secret-file ~/.config/act/secrets \
  -s GITHUB_TOKEN=$GITHUB_TOKEN"
# alias awsl="aws --profile localstack"
alias c='clear'
alias e='exit'

# --------------------- Configs ---------------------

eval "$(starship init bash)"

eval "$(fzf --bash)"
source $HOME/.fzf-bash-completion.sh
bind -x '"\t": fzf_bash_completion'

# --------------------- Pyenv ------------------------

export PYENV_ROOT="$HOME/.pyenv"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES # for ansible
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

command -v pyenv >/dev/null || add_path "$PYENV_ROOT/bin"
if which pyenv-virtualenv-init > /dev/null; then
   eval "$(pyenv init -)";
   eval "$(pyenv virtualenv-init -)"
fi

# --------------------- Completions ---------------------

eval "$(direnv hook bash)"
# eval "$(localstack completion bash)"
# eval "$(minikube completion bash)"
source <(kubectl completion bash)
eval "$(aws-ssm-get completion bash)"
eval "$(aws-r53-get completion bash)"

