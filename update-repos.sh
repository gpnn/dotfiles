#!/usr/bin/env bash

RED='\033[0;31m'
NC='\033[0m'

DIRS=(
	"$HOME/chrome-extensions"
	"$HOME/completions"
)

for DIR in "${DIRS[@]}"; do
	for d in "$DIR"/*/; do
		echo -e "$RED"
		echo -e "$d"
		echo -e "$NC"

		(cd "$d" && git pull origin master --rebase)
	done
done
