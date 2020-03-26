export ZSH="$HOME/.oh-my-zsh"
export UPDATE_ZSH_DAYS=7

ZSH_THEME="robbyrussell"
DISABLE_UPDATE_PROMPT="true"
COMPLETION_WAITING_DOTS="true"
ENABLE_CORRECTION="true"

plugins=(
    brew
    colored-man-pages 
    colorize
    command-not-found
    copydir
    copyfile
    cp
    fzf-tab
    git
    gitignore
    last-working-dir
    npm
    osx
    pip
    safe-paste
    vscode
    z
    zsh-better-npm-completion
    zsh-interactive-cd
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship
SPACESHIP_CHAR_SYMBOL="❯❯ "
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW="true"
SPACESHIP_USER_SHOW="always"
SPACESHIP_HOST_SHOW="always"
SPACESHIP_DIR_TRUNC="0"
SPACESHIP_BATTERY_SHOW="false"

# Allow the use of the z plugin to easily navigate directories
. /usr/local/etc/profile.d/z.sh
# source $(dirname $(gem which colorls))/tab_complete.sh

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP
setopt correct

source /usr/local/share/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

export DOTFILES_ROOT="$HOME/workspace/src/github.com/gpnn/dotfiles/dotfiles"
source "$DOTFILES_ROOT/.aliases"
source "$DOTFILES_ROOT/.exports"
FILE="$HOME/.aliases-home"
if [ -f "$FILE" ]; then
    source "$FILE"
fi

eval "$(direnv hook zsh)"
# following is for vim
# eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
