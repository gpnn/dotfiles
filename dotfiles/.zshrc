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
ZSH_AUTOSUGGEST_USE_ASYNC="true"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8,underline"

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
    fast-syntax-highlighting
    fzf-tab
    git
    git-auto-fetch
    git-extra-commands
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
    you-should-use
    zsh-autosuggestions
    zsh-better-npm-completion
    zsh-completions
    zsh-interactive-cd
)
autoload -Uz compinit && compinit
source $ZSH/oh-my-zsh.sh

[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

HISTSIZE=50000
SAVEHIST=1000
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP
setopt CORRECT
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS
setopt ALWAYS_TO_END
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt MENU_COMPLETE
setopt PROMPT_SUBST
setopt NO_LIST_AMBIGUOUS

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

source "$HOME/.aliases"
source "$HOME/.exports"
source "$HOME/.functions"
FILE="$HOME/.aliases-home"
if [ -f "$FILE" ]; then
    source "$FILE"
fi

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# source /usr/local/opt/git-extras/share/git-extras/git-extras-completion.zsh
# source $HOME/.oh-my-zsh/custom/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/.zsh-autopair/autopair.zsh

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=yellow,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=red,bold'

# eval "$(direnv hook zsh)"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
(( ! ${+functions[p10k]} )) || p10k finalize

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

