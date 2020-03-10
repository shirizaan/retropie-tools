#!/bin/bash

version="0.2"

if [ "$#" -ne 1 ]; then
        echo "Usage: $(basename $0) [file]"
        exit 0
fi

function error() {
	echo -n "$SCRIPTNAME: ERROR occured in line $1: "
	shift
	echo "$@"
}

echo ${0##.*} $version

#Usage Checks
for command in 7z; do
	command -v $command >/dev/null 2>&1
	if (( $? != 0 )); then
		error $LINENO "$command is not installed."
		exit -4
	fi
done

tempdir=$(mktemp -d)
7z e "$1" -o"${tempdir}/" -y
7z a "${1%.*}.7z" "${tempdir}/*"
rm -rf "${tempdir}"
