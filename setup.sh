#!/bin/bash

unameOut="$(uname -s)"
case "${unameOut}" in
Linux*) MACHINE=Linux ;;
Darwin*) MACHINE=Mac ;;
CYGWIN*) MACHINE=Cygwin ;;
MINGW*) MACHINE=MinGw ;;
*) MACHINE="UNKNOWN:${unameOut}" ;;
esac

git clone https://github.com/b4b4r07/enhancd "$HOME"
# git clone https://github.com/lincheney/fzf-tab-completion "$HOME"

if [[ "$MACHINE" == "Linux" ]]; then
  source setup-server.sh
elif [[ "$MACHINE" == "Mac" ]]; then
  source setup-mac.sh
fi
