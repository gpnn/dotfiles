#!/bin/bash

brew list -1 > brews
brew cask list -1 > brew-casks
mas list > brew-mas
brew tap > brew-taps
npm list -g --depth 0 > npm-global