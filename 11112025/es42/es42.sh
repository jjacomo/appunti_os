while read NOME COGNOME N1 DESC ; do
	while read N1M N2 ; do
		if [[ $N1 == $N1M ]] ; then
			while read N2M VERDETTO ; do
				if [[ $N2 == $N2M ]] ; then
					echo "$NOME $COGNOME, accusa: $DESC; verdetto: $VERDETTO"
				fi
			done<verdetti.txt
		fi
	done<processi.txt
done<denunce.txt

