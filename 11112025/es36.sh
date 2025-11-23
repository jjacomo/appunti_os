# Scrivere uno script random.sh che controlla ripetutamente il valore della variabile
# RANDOM e conta quante volte la variabile viene letta. Lo script si interrompe
# quando la variabile RANDOM assume un valore tale che la divisione modulo 10 di
# RANDOM valga esattamente 2. Prima di terminare, lo script scrive in output il
# numero di volte che la variabile e’ stata controllata.

# dalla soluzione (io non lo avevo fatto):
# inizializzo la variabile RANDOM con il numero di secondi
# trascorsi dal 1970-01-01 00:00:00 UTC modulo 32768
RANDOM=$(( `date +%s` % 32768 ))

#======================================================

COUNT=0
RND=$RANDOM
while (( RND % 10 != 2 )) ; do
	(( COUNT++ ))
	RND=$RANDOM
done

echo dopo $COUNT volte, il numero random $RND diviso 10 da resto 2;
