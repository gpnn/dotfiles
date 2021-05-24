#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

GIT_REPOS=(
  "$HOME/.oh-my-zsh"
  "$HOME/.oh-my-zsh/custom/plugins/autoswitch_virtualenv"
  "$HOME/.oh-my-zsh/custom/plugins/deno"
  "$HOME/.oh-my-zsh/custom/plugins/evalcache"
  "$HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting"
  "$HOME/.oh-my-zsh/custom/plugins/fzf-tab"
  "$HOME/.oh-my-zsh/custom/plugins/git-extra-commands/"
  "$HOME/.oh-my-zsh/custom/plugins/you-should-use"
  "$HOME/.oh-my-zsh/custom/plugins/zsh-autopair"
  "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
  "$HOME/.oh-my-zsh/custom/plugins/zsh-better-npm-completion"
  "$HOME/.oh-my-zsh/custom/plugins/zsh-completions"
  "$HOME/.oh-my-zsh/custom/plugins/zsh-history-substring-search"
  "$HOME/.oh-my-zsh/custom/plugins/zsh-nvm"
  "$HOME/.oh-my-zsh/custom/plugins/zsh-pipx/"
  "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
  "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
  "$HOME/enhancd"
)

for directory in "${GIT_REPOS[@]}"; do
  echo -e "$RED"
  echo -e "Updating $directory"
  echo -e "$NC"
  cd "$directory" || continue
  git pull origin master --rebase
done
