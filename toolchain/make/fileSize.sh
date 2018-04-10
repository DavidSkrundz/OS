#!/usr/bin/env bash

if [[ $# -eq 0 ]]; then
	INPUT=/dev/stdin
else
	INPUT=$1
fi

wc -c $INPUT \
	| sed -E "s/[[:space:]]*\s*([[:digit:]]+).*/\1/"
