#!/bin/bash

progname=$(basename $0)

usage() {
	echo "Usage: $progname [OPTION]... REPOSITORY..."
}

help() {
	echo -e "Subversion repository initializer\n"
	usage
	echo -e "\nOptions:"
	echo "  -h:      display this help and exit"
	echo "  -r ARG:  root of repository directory"
	echo "  -s:      initialize repository with standard layout"
	echo "  -f:      overrite repository"
}

root="."
overwrite=false
scriptdir="$(readlink -m "$(dirname "${BASH_SOURCE[0]}")")"
standard=false

while getopts ":hr:fs" opt; do
	case $opt in
		h) help; exit 0;;
		r) root=$OPTARG;;
		f) overwrite=true;;
		s) standard=true;;
		\?) echo "Invalid option $OPTARG"; help; exit 1;;
		:) echo "Option -$OPTARG needs argument"; exit 1;;
	esac
done
shift $((OPTIND-1))


if [ $# -eq 0 ]; then
	usage >&2
	exit 1
fi

root="$(readlink -m "$root")"
if ! [ -d "$root" ]; then
	echo "Not found directory: $root" >&2
	exit 1
fi

for repo in "$@"; do
	path="$root/$repo"
	if [ "$overwrite" = true ]; then
		rm -rf "$path"
	fi
	if [ -e "$path" ]; then
		echo "$repo already exists. To overwrite, give -f option" >&2
		continue
	fi
	svnadmin create "$path" >/dev/null
	rm -rf "$path/conf"
	cp -R "$scriptdir/conf" "$path"
	cp "$scriptdir/hooks/"* "$path/hooks"

	if [ "$standard" = true ]; then
		workingcopy=$(mktemp -d)
		winpty svn co -q "svn://localhost/$repo" "$workingcopy" \
		&& svn mkdir -q "$workingcopy"/{trunk,branches,tags} \
		&& winpty svn ci -q -m "Initial commit" "$workingcopy"
		rm -rf "$workingcopy"
	fi
done
