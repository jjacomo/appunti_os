# Scrivere uno script bash cercarecente.sh che comincia cercando tutti i file con estensione .h in
# tutte le sottodirectory della directory /usr/include/linux/ escludendo i files che si trovano
# direttamente nella directory /usr/include/linux/
# Confrontare la data di ultima modifica dei file così trovati e stampare a video il nome del file
# modificato più recentemente.

FIRST=1
for FILE in $( find /usr/include/linux/* -mindepth 1 -name *.h ) ; do
	if [[ $FIRST == 1 ]] ; then
		MOSTRECENT=$FILE
		FIRST=0
	fi

	if [[ $FILE -nt $MOSTRECENT  ]] ; then
		MOSTRECENT=$FILE
	fi
done

echo $MOSTRECENT
