export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:/usr/sbin:/sbin:$PATH
export PATH=$JAVA_HOME/bin:$PATH
export FZF_BASE="/usr/bin/fzf"
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

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
	fzf-tab
	git
	zsh-interactive-cd
	zsh-syntax-highlighting
    fzf
)

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
alias whatsonport='foo(){sudo netstat -tulpn | grep --color :"$1"}; foo'
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source $ZSH/oh-my-zsh.sh
neofetch
fpath=($fpath "$HOME/.zfunctions")

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Install Ruby Gems to ~/gems
export GEM_HOME=$HOME/gems
export PATH=$HOME/gems/bin:$PATH

# Allow the use of the z plugin to easily navigate directories
. /usr/local/etc/profile.d/z.sh
source $(dirname $(gem which colorls))/tab_complete.sh
#export PATH="/usr/local/share/python:$PATH"

source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship
SPACESHIP_CHAR_SYMBOL="❯❯ "
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW="true"
SPACESHIP_USER_SHOW="always"
SPACESHIP_HOST_SHOW="always"
SPACESHIP_DIR_TRUNC="0"
SPACESHIP_BATTERY_SHOW="false"
