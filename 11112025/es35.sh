COUNT=0

while read RIGA ; do
	# if [[ $(( COUNT%2 == 0 )) ]] ; then E' SBAGLIATO PERCHE' [[ 0 ]] e [[ 1 ]] sono entrambe vere, perche' non sono stringhe vuote
	if (( COUNT % 2 == 0 )) ; then
		echo "$RIGA"
	fi
	(( COUNT = COUNT + 1 ))
done
