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

# ls /usr/include/ > ./ciao.txt
#
# while read X Y Z ; do
# 	echo "(${X};${Y};${Z})"
# done < ciao.txt
#
#AAAAAA


# ATTENZIONE VISTO CHE DICE FILE NON NASCOSTI DOVRESTI FARE NOMIFILES=$(ls)
# invece di ./*

for FILE1 in ./* ; do
	for FILE2 in ./* ; do
		for FILE3 in ./* ; do
			echo "(${FILE1};${FILE2};${FILE3})"
		done
	done
done
