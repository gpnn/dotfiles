#!/bin/bash

XCODE="$(xcode-select --print-path)"
sudo true

if [[ $EUID -gt 0 ]]; then
  echo "Please run with sudo"
  exit
fi

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
xcode-select --reset
