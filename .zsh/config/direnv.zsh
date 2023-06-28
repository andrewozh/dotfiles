export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || zsh_add_path "$PYENV_ROOT/bin"

if which pyenv-virtualenv-init > /dev/null; then
   eval "$(pyenv init -)";
   eval "$(pyenv virtualenv-init -)"
fi

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES # for Ansible
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
