# Scrivere uno script bash discendenti.sh, che prende un argomento intero a riga di
# comando. L'intero indica il numero di script figli da lanciare.
# Ad esempio, all'inizio lo script potrebbe essere lanciato passandogli come
# argomento "3".

if [[ $# != 1 ]]; then
    echo passa solo un argomento intero
    exit 1
fi

if [[ $1 == 0 ]]; then
    exit 0
fi

for ((i = 0; $i < $1; i = $i + 1)); do
    ./discendenti.sh $(($1 - 1)) &
done

wait

echo $1
exit 0
