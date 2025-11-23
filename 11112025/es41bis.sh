# per tutti i file contenuti nella directory /usr/include/ (NON NELLE
# SOTTODIRECTORY) far vedere a video le righe che contengono almeno un carattere
# * e contare quante sono queste righe

COUNT=0
for FILE in /usr/include/* ; do
	if [[ ! -d $FILE ]] ; then 
		# echo $FILE
		(( COUNT= $( grep '*' $FILE | wc -c ) + $COUNT ))
	fi
done

echo $COUNT

# cosa cambia tra questi due ?

grep -d skip '*' /usr/include/* | wc -c
