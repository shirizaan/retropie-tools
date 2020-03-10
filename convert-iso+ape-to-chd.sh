#!/bin/bash

version="0.1"

CURRENT_DIR=$(pwd)
SCRIPTNAME="${0##*/}"
LOGFILE=${CURRENT_DIR}/${SCRIPTNAME%.*}.log

function error() {
	echo -n "$SCRIPTNAME: ERROR occured in line $1: "
	shift
	echo "$@"
}

echo ${SCRIPTNAME} ${version}

#Usage Checks
for command in chdman ffmpeg; do
	command -v $command >/dev/null 2>&1
	if (( $? != 0 )); then
		error $LINENO "$command is not installed."
		exit -4
	fi
done

for filename in *.ape; do
	ffmpeg -i "$filename" "${filename%.*}.wav"
	rm "$filename"
done

for filename in *.cue; do
	chdman createcd -i "$filename" -o "${filename%.*}.chd"
	rm "$filename"
done

