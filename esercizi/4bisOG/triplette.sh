# Scrivere uno script bash triplette.sh che stampa a video tutte le triplette di forma
# (X;Y;Z) dove X Y e Z sono i nomi dei file, non nascosti, nella directory corrente

NUM=0
# for FILE in /usr/include/*; do
    # if ((NUM % 3 == 0)); then
    #     if ((NUM % 2 == 0)); then
    #         echo -n " ("
    #     else
    #         echo -n ") "
    #     fi
    # fi
    #
    # echo "$FILE;"
    #
    # NAAAHHHHH
# done
ls /usr/include/ > ./ciao.txt

while read X Y Z ; do
	echo "(${X};${Y};${Z})"
done < ciao.txt
