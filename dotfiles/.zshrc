#!/bin/bash

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p $HOME/.zinit
    command git clone https://github.com/zdharma-continuum/zinit $HOME/.zinit/bin && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%F" || \
        print -P "%F{160}▓▒░ The clone has failed.%F"
fi

if [[ ! -f $HOME/.iterm2_shell_integration.zsh ]]; then
  curl -L https://iterm2.com/shell_integration/zsh -o $HOME/.iterm2_shell_integration.zsh
fi

source ~/.zinit/bin/zinit.zsh

unameOut="$(uname -s)"

zinit ice depth=1; zinit light romkatv/powerlevel10k

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# cannot load asynchonously because they will overwrite ^I binding for fzf-tab
zinit snippet OMZL::completion.zsh
zinit snippet OMZP::fzf

zinit wait lucid for \
  OMZL::clipboard.zsh \
  OMZL::compfix.zsh \
  OMZL::correction.zsh \
  OMZL::directories.zsh \
  OMZL::functions.zsh \
  OMZL::git.zsh \
  OMZL::grep.zsh \
  OMZL::history.zsh \
  OMZL::key-bindings.zsh \
  OMZL::spectrum.zsh \
  OMZL::termsupport.zsh

  # OMZP::dotenv \
  # OMZP::zsh-interactive-cd

zinit wait lucid for \
  OMZP::alias-finder \
  OMZP::brew \
  OMZP::colored-man-pages \
  OMZP::colorize \
  OMZP::command-not-found \
  OMZP::common-aliases \
  OMZP::copypath \
  OMZP::copyfile \
  OMZP::cp \
  OMZP::docker-compose \
  OMZP::extract \
  OMZP::git \
  OMZP::git-auto-fetch \
  OMZP::git-extras \
  OMZP::gitignore \
  OMZP::golang \
  OMZP::history \
  OMZP::jsontools \
  OMZP::macos \
  OMZP::node \
  OMZP::npm \
  OMZP::pip \
  OMZP::pipenv \
  OMZP::pj \
  OMZP::pyenv \
  OMZP::python \
  OMZP::rsync \
  OMZP::ruby \
  OMZP::rvm \
  OMZP::ubuntu \
  OMZP::urltools \
  OMZP::virtualenv \
  OMZP::vscode \
  OMZP::yarn

[[ ! "$unameOut" == "Darwin" ]] || zinit wait lucid for OMZP::autojump

zinit wait lucid for \
  as"completion" \
    OMZP::ag/_ag \
    OMZP::docker-compose/_docker-compose \
    OMZP::docker/_docker

zinit light-mode for \
  MichaelAquilina/zsh-autoswitch-virtualenv \
  MichaelAquilina/zsh-you-should-use \
  b4b4r07/enhancd \
  dominik-schwabe/zsh-fnm \
  hlissner/zsh-autopair \
  lukechilds/zsh-better-npm-completion \
  unixorn/git-extra-commands \
  wfxr/forgit \
  zdharma-continuum/history-search-multi-word \
  zsh-users/zsh-history-substring-search \
  chitoku-k/fzf-zsh-completions \
  zsh-users/zsh-completions \
  Aloxaf/fzf-tab \
  zsh-users/zsh-autosuggestions \
  zdharma-continuum/fast-syntax-highlighting \
  zsh-users/zsh-syntax-highlighting

[[ ! -f ~/.fzf.zsh ]] || source ~/.fzf.zsh

autoload -Uz compinit
() {
  if [[ $# -gt 0 ]]; then
    compinit;
  else
    compinit -C;
  fi
} ${ZDOTDIR:-$HOME}/.zcompdump(N.mh+24)

if [[ "$unameOut" == "Darwin" ]]; then
  zinit ice lucid wait"0a" from"gh-r" as"program" atload'eval "$(mcfly init zsh)"'
  zinit light cantino/mcfly
  bindkey '^R' mcfly-history-widget
fi

source "$HOME/.iterm2_shell_integration.zsh"

PROJECT_PATHS=(~/workspace)

DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
ENABLE_CORRECTION="true"
ZSH_AUTOSUGGEST_STRATEGY=(history completion match_prev_cmd)
ZSH_AUTOSUGGEST_USE_ASYNC="true"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#b07000,underline,bold"
ZSH_DISABLE_COMPFIX="true"

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=yellow,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=red,bold'
HISTORY_SUBSTRING_SEARCH_FUZZY="true"

HISTFILE=~/.zsh_history
HISTORY_IGNORE="(ls|cd|pwd|exit|ll|history)"
HISTSIZE=10000000
SAVEHIST=$HISTSIZE

setopt always_to_end
setopt auto_cd
setopt auto_menu
setopt auto_pushd
setopt complete_in_word
setopt correct
setopt extended_history
setopt hash_list_all
setopt hist_beep
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt inc_append_history
setopt list_ambiguous
setopt menu_complete
setopt no_list_ambiguous
setopt prompt_subst
setopt pushd_ignore_dups
setopt pushd_minus
setopt share_history

source "$HOME/.aliases"
source "$HOME/.exports"
source "$HOME/.functions"

if [[ "$unameOut" == "Linux" ]] then;
  source "$HOME/.exports-linux"
  source "$HOME/.aliases-linux"
  source "$HOME/.functions-linux"
elif [[ "$unameOut" == "Darwin" ]] then;
  source "$HOME/.exports-mac"
  source "$HOME/.aliases-mac"
  source "$HOME/.functions-mac"
fi

if which brew >/dev/null 2>&1; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

[[ ! -s "/usr/local/etc/grc.zsh" ]] || source /usr/local/etc/grc.zsh

autoload colors && colors
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' verbose yes
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm,cmd -w -w"
zstyle ':completion:*:*:*:default' menu yes select search
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*:descriptions' format '-- %d --'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*:kill:*'   force-list always
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion::complete:*' use-cache on
zstyle ':completion:complete:*:options' sort false
zstyle ':fzf-tab:*' default-color $'\033[34m'
zstyle ':fzf-tab:*' fzf-flags '--color=hl:blue'
zstyle ':fzf-tab:complete:_zlua:*' query-string input
zstyle ':fzf-tab:complete:kill:argument-rest' extra-opts --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

autoload -U edit-command-line
zle -N edit-command-line
bindkey "\ev" edit-command-line
# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

# Keep at bottom
(( ! ${+functions[p10k]} )) || p10k finalize
