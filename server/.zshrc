# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64/"
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:/usr/sbin:/sbin:$PATH"
export PATH="$JAVA_HOME/bin:$PATH"
# export FZF_BASE="/usr/bin/fzf"
export ZSH="$HOME/.oh-my-zsh"
export TZ=America/Montreal
export DOMAIN="gordon-pn.com"

ZSH_THEME="powerlevel10k/powerlevel10k"

DISABLE_AUTO_UPDATE="true"
export UPDATE_ZSH_DAYS=7
COMPLETION_WAITING_DOTS="true"
ENABLE_CORRECTION="true"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP
setopt histignorealldups sharehistory
setopt correct

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

plugins=(
	colored-man-pages
	copydir
	docker
	docker-compose
	fzf
	fzf-tab
	git
	zsh-interactive-cd
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

# source $(dirname $(gem which colorls))/tab_complete.sh
#export PATH="/usr/local/share/python:$PATH"

#        _ _
#   __ _| (_) __ _ ___  ___  ___
#  / _` | | |/ _` / __|/ _ \/ __|
# | (_| | | | (_| \__ \  __/\__ \
#  \__,_|_|_|\__,_|___/\___||___/

# shell
alias reload="exec ${SHELL} -l"
alias change="nano $HOME/.zshrc"
# utilities
alias htop="htop --sort-key=PERCENT_CPU"
alias ncdu="ncdu --color=dark"
# system
alias ls="ls -A -1 --group-directories-first --color=always"
alias mkdir='mkdir -pv'
alias sysup='sudo apt-get update; sudo apt-get upgrade'
alias npmup='npm install npm -g; npm update -g'
alias listd='sudo lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT,LABEL; df -hl'
# do not delete / or prompt if deleting more than 3 files at a time
alias rm='rm -Iv'
# confirmation #
alias mv='mv -iv'
alias cp='cp -iv'
alias ln='ln -iv'
# Parenting changing perms on / #
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
# network
alias ufwnum="sudo ufw status numbered"
alias pingdns="ping -c3 8.8.8.8"
alias pingtest="ping -c3 google.com"
alias st="speedtest-cli --no-upload --bytes"
alias myip="curl http://ipecho.net/plain; echo"
alias myrouter="netstat -nr | grep default"
alias localip="ipconfig getifaddr en0"
# mail
alias checkmail="sudo less /var/mail/$(whoami)"
alias deletemail="sudo rm /var/mail/$(whoami)"
# zombie processes
alias zombie="ps axo stat,ppid,pid,comm | grep -w defunct"

#   __                  _   _
#  / _|                | | (_)
# | |_ _   _ _ __   ___| |_ _  ___  _ __  ___
# |  _| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# | | | |_| | | | | (__| |_| | (_) | | | \__ \
# |_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|___/

function port() {
  sudo netstat -tulpn | grep --color :"$1"
}

function dockerping() {
  docker exec -ti "$1" ping "$2"
}

# select docker contaner to remove
function drm() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker rm "$cid"
}

# select docker container to stop
function ds() {
  local cid
  cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker stop "$cid"
}

fkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo "$pid" | xargs kill -${1:-9}
    fi
}

# cd to selected parent directory
fdr() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf-tmux --tac)
  cd "$DIR" || exit
}

# cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir" || exit
}

enable-fzf-tab

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
(( ! ${+functions[p10k]} )) || p10k finalize
