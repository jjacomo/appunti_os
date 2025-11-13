while read RIGA; do
    echo $RIGA
done <input.txt #ridizionamento dello stdin
# stdin e' input.txt

# ora voglio stampare solo le citta' (dopo il primo ';')
IFS=$';\n'
while read P1 P2 P3; do echo $P2; done <input.txt
# ovviamente mi serve solo P2 che contiene la citta'
