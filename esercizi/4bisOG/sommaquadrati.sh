# Scrivere uno script bash sommaquadrati.sh che prende in input un numero
# qualsiasi di argomenti interi positivi e stampa a video il numero intero dato dalla
# somma dei quadrati dei singoli argomenti diminuito della somma degli indici degli
# argomenti

NUM=0

# for N in $@ ; do
# 	(( NUM=$NUM + N * N ))
# done
for (( i=1; i<=$# ; i++ )) ; do 
	(( NUM = $NUM + ${!i} * ${!i} - $i ))
done

echo $NUM

