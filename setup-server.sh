#!/bin/bash

if [[ $EUID -gt 0 ]]; then
	echo "Please run with sudo"
	exit 1
fi

unameOut="$(uname -s)"
case "${unameOut}" in
	Linux*) MACHINE=Linux ;;
	Darwin*) MACHINE=Mac ;;
	CYGWIN*) MACHINE=Cygwin ;;
	MINGW*) MACHINE=MinGw ;;
	*) MACHINE="UNKNOWN:${unameOut}" ;;
esac

if [[ "$MACHINE" != "Linux" ]]; then
	echo "$MACHINE is not supported"
	exit 1
fi

if [ -f /etc/os-release ]; then
	. /etc/os-release
	DISTRO=$NAME
else
	echo "Cannot determine Distro"
fi

if [[ "$DISTRO" != *"Rasp"* ]] && [[ "$DISTRO" != *"Debian"* ]] && [[ "$DISTRO" != *"Ubuntu"* ]]; then
	echo "$DISTRO is not supported"
	exit 1
fi

install_zsh_etc() {
	apt update
	apt -y install \
		apt-transport-https \
		ca-certificates \
		curl \
		gnupg-agent \
		npm \
		silversearcher-ag \
		software-properties-common \
		zsh
	zsh --version
	chsh -s /bin/zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k
	git clone https://github.com/Aloxaf/fzf-tab ~ZSH_CUSTOM/plugins/fzf-tab
	git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ~ZSH_CUSTOM/plugins/you-should-use
	git clone https://github.com/hlissner/zsh-autopair ~ZSH_CUSTOM/plugins/.zsh-autopair
	git clone https://github.com/lukechilds/zsh-better-npm-completion ~ZSH_CUSTOM/plugins/zsh-better-npm-completion
	git clone https://github.com/unixorn/git-extra-commands.git ~ZSH_CUSTOM/plugins/git-extra-commands
	git clone https://github.com/zdharma/fast-syntax-highlighting.git ~ZSH_CUSTOM/plugins/fast-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-autosuggestions ~ZSH_CUSTOM/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-history-substring-search ~ZSH_CUSTOM/plugins/zsh-history-substring-search
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~ZSH_CUSTOM/plugins/zsh-syntax-highlighting
}

install_docker() {
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
	apt update
	apt -y install \
		docker-ce \
		docker-ce-cli \
		containerd.io
	curl -L --fail https://github.com/docker/compose/releases/download/1.26.2/run.sh -o /usr/local/bin/docker-compose
	chmod +x /usr/local/bin/docker-compose
}

create_symlinks() {
	DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
	for file in "$DIR"/dotfiles/.*; do
		if [ -d "$file" ] || [[ "$file" == *"gitconfig"* ]]; then
			continue
		fi
		ln -sfn "$file" /home/gordonpn
	done
}

read -r -p "Install zsh? [y/N] " response
response=${response,,}
if [[ "$response" =~ ^(yes|y)$ ]]; then
	install_zsh_etc
fi

read -r -p "Install Docker? [y/N] " response
response=${response,,}
if [[ "$response" =~ ^(yes|y)$ ]]; then
	install_docker
fi

create_symlinks
