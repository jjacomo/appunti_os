# scrivere una riga di comando che legge righe da standard input e per ciascuna di
# queste mette in output il numero di caratteri che la compongono.

while read RIGA; do
    # echo $RIGA | wc -c  BRUTTO COGLIONE
    echo ${#RIGA}
done
