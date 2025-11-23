# Scrivere uno script elenco.sh che elenca tutti i file e directory presenti nella
# directory corrente (escludendo dall'elenco la directory corrente, la directory
# superiore e i files nascosti). Per ciascuno di questi file e directory, lo script controlla
# se si tratta di una directory o no. Se si tratta di una directory lo script conta la
# lunghezza del nome della directory e lo accumula in una variabile locale
# LungNomiDirectory. Lo script, inoltre conta i file che non sono delle directory. Al
# termine lo script visualizza in output il numero di file di tipo non directory e la
# lunghezza accumulata dei nomi delle directory lette

# lo faccio con /usr/include/

LungNomiDirectory=0
NUMFILES=0

# for FILE in $(find /usr/include -maxdepth 1 -mindepth 1) ; do
for FILE in $(ls ./) ; do
	if [[ -d $FILE ]] ; then
		(( LungNomiDirectory=$LungNomiDirectory + ${#FILE} ))
		# echo directory: $FILE
		# LungNomi
	else
		# echo file: $FILE
		(( NUMFILES++ ))
	fi
done

echo la somma dei caratteri delle directory e $LungNomiDirectory
echo il numero di file trovati invece e $NUMFILES
