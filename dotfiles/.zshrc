# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
export UPDATE_ZSH_DAYS=7
export DOTFILES_ROOT="$HOME/workspace/src/github.com/gordonpn/dotfiles"

ZSH_THEME="powerlevel10k/powerlevel10k"
DISABLE_UPDATE_PROMPT="true"
COMPLETION_WAITING_DOTS="true"
ENABLE_CORRECTION="true"
ZSH_AUTOSUGGEST_STRATEGY=(history completion match_prev_cmd)
ZSH_AUTOSUGGEST_USE_ASYNC=""

plugins=(
    autojump
    brew
    colored-man-pages
    colorize
    command-not-found
    copydir
    copyfile
    cp
    docker
    docker-compose
    encode64
    extract
    fzf-tab
    git
    git-auto-fetch
    gitignore
    golang
    gradle
    history-substring-search
    httpie
    last-working-dir
    mvn
    npm
    osx
    pip
    safe-paste
    urltools
    virtualenvwrapper
    vscode
    zsh-autosuggestions
    zsh-better-npm-completion
    zsh-completions
    zsh-interactive-cd
    zsh-syntax-highlighting
)
autoload -Uz compinit && compinit
source $ZSH/oh-my-zsh.sh

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

source "$HOME/.aliases"
source "$HOME/.exports"
source "$HOME/.functions"
FILE="$HOME/.aliases-home"
if [ -f "$FILE" ]; then
    source "$FILE"
fi

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

source /usr/local/opt/git-extras/share/git-extras/git-extras-completion.zsh

eval "$(direnv hook zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
(( ! ${+functions[p10k]} )) || p10k finalize

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

