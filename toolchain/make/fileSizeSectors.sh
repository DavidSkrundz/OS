#!/usr/bin/env bash

# Returns the number of sectors a file takes
# Usage: ./fileSizeSectors.sh <bytesPerSector> [file]
#
# If file is omitted /dev/stdin is used

if [[ $# -lt 1 ]]; then
	echo "Missing bytes per sector argument"
	exit 1
fi

if [[ $# -gt 2 ]]; then
	echo "Too many arguments"
	exit 1
fi

BYTES_PER_SECTOR=$1
case $BYTES_PER_SECTOR in
	''|*[!0-9]*)
		echo "Bytes per sector must be a number"
		exit 1
		;;
	*)
		;;
esac
INPUT=$2
if [[ $# -eq 1 ]]; then
	INPUT=/dev/stdin
fi

BYTES=`wc -c $INPUT \
	| sed -E "s/[[:space:]]*([[:digit:]]+).*/\1/"`
echo $(( ( $BYTES + $BYTES_PER_SECTOR - 1 ) / $BYTES_PER_SECTOR ))
