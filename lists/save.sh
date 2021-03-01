#!/bin/bash

if [ -f "Brewfile" ]; then
  rm "Brewfile"
fi
npm root -g
npm list -g --depth 0 | tail --lines=+2 >npm-global
brew bundle dump --all
