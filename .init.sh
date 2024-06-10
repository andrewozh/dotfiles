#!/bin/bash
set -x

echo Install Homebrew..
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

echo Configure github creds..
echo git config --global credential.helper osxkeychain
echo git config --global --unset credential.helper
echo git credential-osxkeychain erase

echo Install andrewozh/dotfiles..
BARE_REPO=$HOME/.dotfiles
GIT_OPTS="--git-dir=$BARE_REPO --work-tree=$HOME"
git init --bare $BARE_REPO
git --git-dir=$BARE_REPO --work-tree=$HOME remote add origin https://github.com/andrewozh/dotfiles.git
git --git-dir=$BARE_REPO --work-tree=$HOME pull origin main

echo Install brew bundles..
brew bundle install

echo Setup modern bash as default shell..
BREW_BASH="$(brew --prefix)/bin/bash"
if [[ -f "$BREW_BASH" ]] ; then
  echo $BREW_BASH | sudo tee -a /private/etc/shell
  chsh -s $BREW_BASH
  sudo chpass -s $BREW_BASH $USER
else
  echo "Failed to find bash!"
  exit 1
fi

echo Use k9s config
rm -rf ~/Library/Application\ Support/k9s
ln -s ~/.config/k9s ~/Library/Application\ Support/k9s

ln -s "/Users/andrewozh/Library/Mobile Documents/iCloud~md~obsidian/Documents/notes" ~/Notes

cat<<EOF
Software to install manually:

* YTUntrap (AppStore)
* OpenVPN Client
* MacGPT
* RadioGaga

Done! Logout required.

