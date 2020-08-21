#!/bin/bash

unameOut="$(uname -s)"
case "${unameOut}" in
Linux*) MACHINE=Linux ;;
Darwin*) MACHINE=Mac ;;
CYGWIN*) MACHINE=Cygwin ;;
MINGW*) MACHINE=MinGw ;;
*) MACHINE="UNKNOWN:${unameOut}" ;;
esac

if [[ "$MACHINE" != "Mac" ]]; then
	echo "$MACHINE is not supported"
	exit 1
fi

echo "$MACHINE is supported"
echo "Installing Homebrew..."
read -n 1 -s -r -p "Press any key to continue"
echo
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
open -a "App Store"
echo "Please make sure you are logged into the App Store then continue"
read -n 1 -s -r -p "Press any key to continue"
echo
gem install colorize
brew bundle install --file="$(pwd)"/lists/Brewfile
ruby ./setup.rb
