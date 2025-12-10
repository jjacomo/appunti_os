#!/bin/bash

# Scrivere un piccolo script chiama_fattoriale.sh il quale invoca lo script
# fattoriale.sh passandogli l’argomento 5 e cattura dallo stdout il risultato prodotto
# dal fattoriale, mettendolo in una variabile denominata RISULTATO. Scrivere poi lo
# script fattoriale.sh che prende in input un argomento intero positivo e calcola il
# fattoriale di quel numero. Lo script fattoriale.sh scrive il risultato sullo stdout.

if [ $# != 1 ]; then
    echo passami solo 1 argomento
    exit 1
fi

echo ok

NUM=1
for ((i = 1; i <= $1; i++)); do
    ((NUM = $NUM * $i))
done
