#!/bin/sh

# Usage:
#	scripts/run_test.sh <test> <algoritmo> <cantidad> <timeout>

test=$1
algo=$2
veces=$3
timeout=$4

die() {
	echo "$@"
	exit
}

i=0
while [ "$i" -lt "$veces" ]; do
	timeout "${timeout}s" "$algo" < "$test" || die Timeout
	i=$((i + 1))
done

exit 0
