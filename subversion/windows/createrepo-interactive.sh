#!/bin/bash

default_root=${SVNREPO_HOME:-"./"}
read -p "root directory (default: $default_root): " root
root="${root:-"$default_root"}"
root="$(readlink -m "$root")"

if [ ! -d "$root" ]; then
	echo "$root not found." >&2
	exit 1
fi

options=("-r$root")

read -p "repository name: " name

path="$root/$name"
if [ -e "$path" ]; then
	read -p "$path is already exists. overwrite it? (y/N)" -n 1; echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		options+=("-f")
	else
		exit 0
	fi
fi


read -p "standard layout? (y/N) " -n 1; echo
if [[ "$REPLY" =~ ^[Yy] ]]; then
	options+=("-s")
fi

scriptdir="$(dirname "${BASH_SOURCE[0]}")"
"$scriptdir/createrepo.sh" "${options[@]}" "$name"
#./args.sh "${options[@]}" "$name"
read -n 1 -p "Press any key to continue."