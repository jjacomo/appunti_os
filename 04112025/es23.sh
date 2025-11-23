# Scrivere uno script bash leggerecaratteri.sh che legge uno per uno i caratteri del file /usr/include/stdio.h e stampa a video il numero dei caratteri letti dal file

CONTA=0
while read -n 1 CHAR ; do
	(( CONTA=CONTA + 1 ))
done < /usr/include/stdio.h

echo ho letto $CONTA caratteri!
