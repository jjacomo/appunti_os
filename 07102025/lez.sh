echo ciao sono lo script $0
echo "ho ricevuto questi $# argomenti: $*"
# i doppi apici non sono essenziali, era per mostrare che
# l'espansione delle var non viene disabilitata. Con gli
# apici singoli si pero'

echo ora li stampo uno sotto l\'altro con un for
for name in $*; do
    echo $name
done

# attento che cosi' se passi gli argomenti: "trota salmone" sgombro
# che pensi che sarebbero 2 (e lo sono) il for ne vede 3
# (i doppi apici vengono rimossi!!)

# attento a non fare
# for name in "$*" ...
# cosi' vede sono un unico name bello lungo (e' un unica stringa)
# PERO' PUOI FARE
# for name in "$@" ...
# e cosi' funziona anche se metti degli input tra doppi apici
# funziona perche' $@ in realta' e' un vettore e quando lo
# scrivo tra apici doppi mi quota dentro gli apici ogni casella
# del vettore!

# dopo in metto i valori tra cui deve girare la var a prima
# potevo scrivere anche for pesce in trota salmone sgombro...
