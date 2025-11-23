# Verificare se il seguente comando va a buon fine oppure produce errori ed in
# questo ultimo caso capire quale è il problema.
for (( i=0; $(ls ./) ; i=i+1 )) ; do echo "${i}" ; done
