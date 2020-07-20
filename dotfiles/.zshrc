#!/bin/bash

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
DISABLE_UPDATE_PROMPT="true"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
ENABLE_CORRECTION="true"
ZSH_AUTOSUGGEST_STRATEGY=(history completion match_prev_cmd)
ZSH_AUTOSUGGEST_USE_ASYNC="true"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8,underline"

plugins=(
	colored-man-pages
  colorize
  command-not-found
  cp
  encode64
  extract
  fast-syntax-highlighting
  fzf-tab
  git
  git-auto-fetch
  git-extra-commands
  history-substring-search
  httpie
  last-working-dir
  npm
  safe-paste
  urltools
  you-should-use
  zsh-autopair
  zsh-autosuggestions
  zsh-better-npm-completion
  zsh-completions
	docker
	docker-compose
	fzf
	fzf-tab
	git
	zsh-interactive-cd
	zsh-syntax-highlighting
)

autoload -Uz compinit && compinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

HISTFILE=~/.zsh_history
HISTORY_IGNORE="(ls|cd|pwd|exit|ll|history)"
HISTSIZE=10000000
SAVEHIST=10000000
setopt ALWAYS_TO_END
setopt AUTO_CD
setopt AUTO_MENU
setopt AUTO_PUSHD
setopt COMPLETE_IN_WORD
setopt CORRECT
setopt EXTENDED_HISTORY
setopt HIST_BEEP
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt MENU_COMPLETE
setopt NO_LIST_AMBIGUOUS
setopt PROMPT_SUBST
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS
setopt SHARE_HISTORY

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

unameOut="$(uname -s)"
case "${unameOut}" in
  Linux*) MACHINE=Linux ;;
  Darwin*) MACHINE=Mac ;;
  CYGWIN*) MACHINE=Cygwin ;;
  MINGW*) MACHINE=MinGw ;;
  *) MACHINE="UNKNOWN:${unameOut}" ;;
esac

if [[ "$MACHINE" == "Linux" ]]; then
  source "$HOME/.zshrc-server"
elif [[ "$MACHINE" == "Mac" ]]; then
  source "$HOME/.zshrc-mac"
fi

source "$HOME/.aliases"
source "$HOME/.exports"
source "$HOME/.functions"

enable-fzf-tab

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=yellow,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=red,bold'
HISTORY_SUBSTRING_SEARCH_FUZZY="true"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
(( ! ${+functions[p10k]} )) || p10k finalize

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
