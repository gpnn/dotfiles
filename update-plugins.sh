RED='\033[1;33m'
NC='\033[0m'

GIT_REPOS=(
    $HOME/.nano/nanorc
    $HOME/.oh-my-zsh
    $HOME/.oh-my-zsh/custom/plugins/fzf-tab
    $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    $HOME/.oh-my-zsh/custom/plugins/zsh-better-npm-completion
    $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
		$HOME/.oh-my-zsh/custom/themes/powerlevel10k
)

for directory in "${GIT_REPOS[@]}"; do
    echo ${RED}
    echo "Updating $directory"
    echo ${NC}
    cd "$directory"
    git pull origin master
done
