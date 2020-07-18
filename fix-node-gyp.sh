#!/bin/bash

XCODE="$(xcode-select --print-path)"

if [[ $EUID -gt 0 ]]
    then echo "Please run with sudo"
    exit
fi

printf "\nWill try resetting xcode first\n\n"
read -n 1 -s -r -p "Press any key to continue"
xcode-select --reset
printf "\n\n\n"
printf "Try running the npm command again in a different terminal shell.\n\n"
read -n 1 -s -r -p "Press any key to continue if it did not solve the problem"

if [ -d "$XCODE" ]; then
    printf "\n\n\n"
    printf "xcode exists at path %s \n\n" "$XCODE"
    printf "Will delete\n"
    read -n 1 -s -r -p "Press any key to continue"
    printf "\n\n\n"
    printf "Deleting, please wait...\n\n"
    rm -rf "$XCODE"
fi

printf "\n\n\n"
printf "Will prompt to install xcode now\n\n"
read -n 1 -s -r -p "Press any key to continue"
printf "\n\n\n"
xcode-select --install
printf "\n\n\n"
read -n 1 -s -r -p "Press any key when xcode is done installing"
printf "\n\n\n"
printf "Installing latest npm and latest node-gyp\n\n"
npm install -g npm@latest node-gyp@latest
