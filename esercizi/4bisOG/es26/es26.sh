#!/bin/bash

# Creare una directory BUTTAMI, dentro questa creare dei file che si chiamano
# * ** *** ;;
mkdir BUTTAMI
cd BUTTAMI
touch "*" "**" "***"

# Fare un listing di questi file e poi, per ciascuno dei file nella directory aggiungere un
# nuovo file con stesso nome con in più l'estensione .txt.
ls .
for FILE in *; do
    touch "${FILE}.txt"
done
# ls .

# Copiare in questa directory tutta la directory /usr/include/ (e i suoi file e
# sottodirectory ricorsivamente).
cp -r /usr/include/ .

# Stampare a video tutte le sottodirectory (non i file) della vostra directory BUTTAMI
# comprese le sottodirectory delle sottodirectory e così via ricorsivamente.
find . -type d
# ls -R

# Eliminare la directory "include" nella vostra directory BUTTAMI (eliminare anche
# tutti i file e sottodirectory di include, ATTENTI A NON ELIMINARE l'ORIGINALE
# /usr/include
rm -rf ./usr/include

# PUlisco
cd ..
rm -rf BUTTAMI
