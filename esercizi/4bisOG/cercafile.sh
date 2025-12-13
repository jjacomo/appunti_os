#!/bin/bash
# Scrivere uno script cercafile.sh che, per ciascuna lettera che sta tra c e g cerca i
# file (o directory) che stanno nella directory /usr/include (non nelle sottodirectory) e
# che hanno quella lettera come secondo carattere del nome del file, e che verificano
# una delle due seguenti proprietà: la lunghezza del percorso assoluto del file è
# minore di 18 OPPURE è maggiore di 23. Di questi file stampa in output il percorso
# assoluto.

# VAR='{'
for LETTER in {c..g}; do
    echo
    echo $LETTER :
    for FILE in /usr/include/?${LETTER}*; do
        if ((${#FILE} < 18 || ${#FILE} > 23)); then
            echo $FILE
        fi
    done
done

# echo cia{a..d}o
