#!/bin/bash

sudo true

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

if [[ $EUID -gt 0 ]]; then
	echo "Please run with sudo"
	exit
fi

install_zsh_etc() {
	# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

	sudo apt update
	sudo apt -y install \
		apt-transport-https \
		ca-certificates \
		curl \
		fzf \
		gnupg-agent \
		npm \
		silversearcher-ag \
		software-properties-common \
		zsh

	zsh --version
	chsh -s /bin/zsh
}

install_docker() {
	if [[ "$(arch)" == "x86_64" ]]; then
		ARCH="amd64"
	elif [[ "$(arch)" == "aarch64" ]]; then
		ARCH="arm64"
	fi

	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository "deb [arch=$ARCH] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
	sudo apt update
	sudo apt -y install \
		docker-ce \
		docker-ce-cli \
		containerd.io

	COMPOSE_VERSION=$(git ls-remote https://github.com/docker/compose | grep refs/tags | grep -oE "[0-9]+\.[0-9][0-9]+\.[0-9]+$" | sort --version-sort | tail -n 1)
	curl -L --fail "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/run.sh" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
}

create_symlinks() {
	DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
	for file in "$DIR"/dotfiles/.*; do
		if [ -d "$file" ] || [[ "$file" == *"gitconfig"* ]]; then
			continue
		fi
		file_name="${file##*/}"
		ln -sfn "$file" /home/gordonpn/"$file_name"
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
