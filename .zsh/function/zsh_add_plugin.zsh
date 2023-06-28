function zsh_add_plugin {
  local source="${1}"
  local plugin_name=$(basename "$source" .git)
  local plugin_dir="$ZSH_PLUGIN_DIR/$plugin_name"

  if [[ -z "$source" ]]; then
    echo "zsh_add_plugin: empty repo specified!"
    return 1
  fi

  if [[ ! -d "$plugin_dir" ]]; then
    read "reply?Plugin '$plugin_name' is not present. Install it? (y/n) "
    if [[ $reply =~ ^[Yy]$ ]]; then
      git clone "$source" "$plugin_dir"
    fi
  else
    git -C "$plugin_dir" fetch
    local repo_status=$(git -C "$plugin_dir" status)
    if [[ $repo_status != *"Your branch is up to date"* ]]; then
      read "reply?Plugin '$plugin_name' has updates. Update it? (y/n) "
      if [[ $reply =~ ^[Yy]$ ]]; then
        git -C "$plugin_dir" pull
      fi
    fi
  fi
}
