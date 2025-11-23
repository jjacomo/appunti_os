# Scrivere uno script reversebizzarro.sh che prende una stringa come unico
# argomento e mette in output la stringa con i caratteri in ordine invertito, il primo
# andrà per ultimo, l'ultimo per primo. Per complicarvi la vita, per implementare questo
# script potete utilizzare solo assegnamenti a variabili, cicli ed if a piacere, ed i
# comandi echo read e cut. Si suppone che la stringa passata come argomento non
# contenga caratteri e metacaratteri interpretati dalla bash.

R_STRING=""

while read -N 1 CHAR ; do
	# echo char: $CHAR
	R_STRING="$CHAR$R_STRING"
done <ciao.txt

echo $R_STRING
