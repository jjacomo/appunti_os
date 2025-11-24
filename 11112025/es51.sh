# Scrivere uno script puntini.sh che prende come argomento a riga di comando un
# intero positivo che rappresenta un certo numero di secondi. Lo script deve rimanere
# in esecuzione per quel numero di secondi e, ad ogni secondo, stampare a video un
# punto . seguito dal proprio PID. Ma senza andare a capo.

if [[ ! $# -eq 1 ]]; then
    echo inserisci solo un numero
fi

COUNT=0
echo $COUNT

for ((i = 0; i < $COUNT; i++)); do
    sleep 1
    echo -n ". $PID"
done
