#!/bin/bash

if [ -f "Brewfile" ]; then
	rm "Brewfile"
fi
npm root -g
npm ls -g --depth=0 --parseable | grep -o 'node_modules/.*$' | sed 's:node_modules/::g' >npm-global
brew bundle dump --all
