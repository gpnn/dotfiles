#!/bin/bash

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     MACHINE=Linux;;
    Darwin*)    MACHINE=Mac;;
    CYGWIN*)    MACHINE=Cygwin;;
    MINGW*)     MACHINE=MinGw;;
    *)          MACHINE="UNKNOWN:${unameOut}"
esac

if [[ "$MACHINE" != "Mac" ]]; then
    echo "$MACHINE is not supported"
    exit 1
fi

echo "$MACHINE is supported"
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh
open -a "App Store"
echo "Please mak sure you are logged into the App Store then continue"
read -n 1 -s -r -p "Press any key to continue"
gem install colorize
ruby ./setup.rb
