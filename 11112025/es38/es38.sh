# Scrivere un file contenente alcune (almeno 5) righe di testo, ciascuna con almeno 4
# parole. Scrivere uno script seconda.sh che prende come unico argomento il nome
# di quel file. Dentro lo script utilizzare ripetutamente il comando read per leggere la
# seconda parola di ogni riga del file. Tutte le seconde parole devono essere
# concatenata in una variabile di nome OUT. Alla fine dello script, la variabile OUT
# deve essere visualizzata sullo standard output.

if [[ $# != 1 ]] ; then
	echo "expected: <file_name>. Got: $@"
	exit 1
fi

if [[ ! -r $1 ]] ; then echo "file $1 does not exist terminating with exit status 2" ; exit 1 ; fi

FILE=$1
OUT=""
while read WORD1 WORD2 REST ; do
	OUT="$OUT $WORD2"
done <$FILE

echo $OUT
