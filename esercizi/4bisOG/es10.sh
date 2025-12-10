# Scrivere uno script che usa anche il comando for per visualizzare, per ciascun file
# della directory corrente che non inizia per . , una coppia di righe in cui:
# la prima riga contiene la stringa “file is ” seguita dal nome del file
# la seconda riga fa il listing delle informazioni sul file. Se il file è una directory, il
# listing deve contenere solo il nome della directory, non quello dei suoi files.

for FILE in *; do
    echo file is $FILE
    ls -ld $FILE
done

# Ripetere la prova precedente, stavolta tutto il comando for do done su una unica
# riga, aggiungendo le necessarie modifiche per ottenere lo stesso risultato di prima.

# for FILE in *; do echo file is $FILE ; ls -ld $FILE ; done

# Modificare lo script per verificare se il comando ls è andato a buon fine e, in caso
# contrario, stampare a video un avviso "ls produce errore"

for FILE in *; do
    echo file is $FILE
    ls -ld $FILE
    if (($? == 0)); then
        echo ls e andato a buon fine
    fi
done
