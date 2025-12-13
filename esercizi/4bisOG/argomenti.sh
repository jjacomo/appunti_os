#!/bin/bash

if [ $# == 0 ] ; then
	echo HAI INSERITO ZERO ARGOMENTI
	exit 1
fi

PARI=""
DISPARI=""
STR=""

for (( i=2 ; $i <= $# ; i=$i+2 )) ; do
	STR="$STR ${!i}"
done
for (( i=1 ; $i <= $# ; i=$i+2 )) ; do
	STR="$STR ${!i}"
done

echo $STR
