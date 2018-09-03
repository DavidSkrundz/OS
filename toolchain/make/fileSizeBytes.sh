#!/usr/bin/env bash

# Returns the number of bytes in a file
# Usage: ./fileSizeBytes.sh [file]
#
# If file is omitted /dev/stdin is used

if [[ $# -gt 1 ]]; then
	echo "Too many arguments"
	exit 1
fi

INPUT=$1
if [[ $# -eq 0 ]]; then
	INPUT=/dev/stdin
fi

wc -c $INPUT \
	| sed -E "s/[[:space:]]*([[:digit:]]+).*/\1/"
