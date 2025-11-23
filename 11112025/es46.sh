# scrivere una riga di comando che mette sullo standard output delle righe con i primi
# 3 caratteri delle ultime 4 righe del file /usr/include/stdio.h
tail -n 4 /usr/include/stdio.h | cut -c -3
# | read -n 3 NON FUNZIONA

