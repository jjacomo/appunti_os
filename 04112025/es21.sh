# Stampare a video le sole righe del file /usr/include/stdio.h che NON contengono alcun asterisco *
# Suggerimento2: Guardare il man di grep per capire come usare grep in modo opportuno.

grep -v \* /usr/include/stdio.h
