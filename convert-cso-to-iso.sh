#!/bin/bash

version="0.1"

if [ "$#" -ne 1 ]; then
	echo "Usage: $(basename $0) [cso file]"
	exit 0
fi

function error() {
	echo -n "$SCRIPTNAME: ERROR occured in line $1: "
	shift
	echo "$@"
}

echo ${0##.*} $version

#Usage Checks
for command in ciso; do
	command -v $command >/dev/null 2>&1
	if (( $? != 0 )); then
		error $LINENO "$command is not installed."
		exit -4
	fi
done

ciso 0 "$1" "${1%.*}.iso"

