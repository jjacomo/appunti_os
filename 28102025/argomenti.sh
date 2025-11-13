echo stampa dispari e poi pari
NOMI=""
for ((i = 1; $i <= $#; i = $i + 2)); do
    NOMI="$NOMI ${!i}"
done

for ((i = 2; $i <= $#; i = $i + 2)); do
    NOMI="$NOMI ${!i}"
done

echo $NOMI
