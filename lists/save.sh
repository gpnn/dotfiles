#!/bin/bash

brew list -1 > brews-new
brew cask list -1 > brew-casks-new
mas list > brew-mas-new
brew tap > brew-taps-new
npm list -g --depth 0 > npm-global-new
