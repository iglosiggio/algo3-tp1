#!/bin/sh

# Usage:
#	scripts/run_test.sh <test> <algoritmo> <cantidad> <timeout>

test=$1
algo=$2
veces=$3
timeout=$4

run_with_timeout() (
	"$algo" < "$test" &
	corrida=$!
	(
		sleep "$timeout"
		if [ -d /proc/$corrida ]; then
			kill $corrida
			echo error timeout
		fi
	) &
	limite=$!
	wait $corrida
	rval=$?
	[ -d /proc/$limite ] && kill $limite
	return $rval
)

i=0
while [ "$i" -lt "$veces" ]; do
	run_with_timeout || exit 1
	i=$((i + 1))
done

exit 0
