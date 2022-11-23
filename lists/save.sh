#!/bin/bash

pnpm_marker="/node_modules/.pnpm/"

if [ -f "Brewfile" ]; then
	rm "Brewfile"
fi
npm root -g
npm ls -g --depth=0 --parseable | grep -o 'node_modules/.*$' | sed 's:node_modules/::g' >npm-global
brew bundle dump --all
pnpm ls -g --parseable --depth 0 | grep -i "$pnpm_marker" | awk -F"$pnpm_marker" '{print $2}' | awk -F'@' '{print $1}' >pnpm-global
