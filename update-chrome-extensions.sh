#!/usr/bin/env bash

RED='\033[0;31m'
NC='\033[0m'

DIR="$HOME/chrome-extensions"

for d in "$DIR"/*/; do
  echo -e "$RED"
  echo -e "$d"
  echo -e "$NC"

  (cd "$d" && git pull origin master --rebase)
done
