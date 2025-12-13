#!/bin/bash

# Scrivere uno script cercadir.sh che cerca tra tutti i file e directory contenuti nella
# directory /usr/include (non nelle sue sottodirectory) e stampa in output il percorso
# assoluto dei file che verificano tutte le seguenti proprietà: a) sono delle directory, b)
# hanno il permesso di lettura da parte dello user attuale, c) la data di ultima modifica
# del file è strettamente più recente di quella del file /usr/include/stdio.h

for FILE in /usr/include/*; do
    if [[ -d $FILE && -r $FILE && $FILE -nt /usr/include/stdio.h ]]; then
        echo "il file $FILE e' una directory, hai i permessi di lettura, ed e' piu' recente di stdio.h"
    fi
done
