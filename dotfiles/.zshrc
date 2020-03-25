export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

DISABLE_UPDATE_PROMPT="true"

export UPDATE_ZSH_DAYS=7

COMPLETION_WAITING_DOTS="true"

plugins=(
    brew
    colored-man-pages 
    colorize
    command-not-found
    copydir
    copyfile
    git
    gitignore
    last-working-dir
    npm
    osx
    pip
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
source /usr/local/share/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
SPACESHIP_CHAR_SYMBOL="➜➜ "
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW="true"
SPACESHIP_USER_SHOW="true"

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

export DOTFILES_ROOT="$HOME/workspace/src/github.com/gpnn/dotfiles/dotfiles"
source "$DOTFILES_ROOT/.aliases"
source "$DOTFILES_ROOT/.exports"
FILE=.aliases-home
if [ -f "$FILE" ]; then
    source "$HOME/$FILE"
fi