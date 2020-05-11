#!/usr/bin/env bash

RED='\033[0;31m'
NC='\033[0m'

GIT_REPOS=(
	"$HOME/.nano/nanorc"
	"$HOME/.oh-my-zsh"
	"$HOME/.oh-my-zsh/custom/plugins/fzf-tab"
	"$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
	"$HOME/.oh-my-zsh/custom/plugins/zsh-better-npm-completion"
	"$HOME/.oh-my-zsh/custom/plugins/zsh-history-substring-search"
	"$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
	"$HOME/.oh-my-zsh/custom/plugins/zsh-autocomplete"
	"$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
)

for directory in "${GIT_REPOS[@]}"; do
    echo -e "$RED"
    echo -e "Updating $directory"
    echo -e "$NC"
    cd "$directory" || continue
    git pull origin master
done
