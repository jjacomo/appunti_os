# Scrivere uno script bash leggere.sh che legge le righe del file /usr/include/stdio.h
# e stampa a video la sola terza parola di ciascuna riga, o niente se la terza parola
# non esiste


exec {FD}</usr/include/stdio.h
 
if (( $? == 0 )) ; then
	while read -u $FD VAR1 VAR2 VAR3 VAR4; do
		echo riga: $VAR3
	done 
	exec {FD}>&-
fi

# non so perche' il suo e' cosi' tanto piu' articolato
# OK ADESSO KIND OF YES
