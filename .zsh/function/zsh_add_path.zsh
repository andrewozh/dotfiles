function zsh_add_path {
  [ ! -d "${1}" ] && echo "[WARN] ZSH PATH '$1' doesn't exist!" >&2
  export PATH="$1:$PATH"
} 
