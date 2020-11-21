#!/bin/bash

npm list -g --depth 0 | tail --lines=+2 >npm-global-new
brew bundle dump --all
