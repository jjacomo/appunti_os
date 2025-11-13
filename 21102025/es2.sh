# Dall’interno di una shell bash, eseguire lo script crea_var.sh in un modo tale che la
# variabile PIPPO sia presente (col nuovo contenuto) dentro la bash chiamante dopo
# la fine dell’esecuzione dello script crea_var.sh

PIPPO=$USER$HOME$DISPLAY
# oppure
# PIPPO="$USER $HOME $DISPLAY"
echo $PIPPO
