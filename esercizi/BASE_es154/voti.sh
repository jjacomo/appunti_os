### Nei commenti che seguono vedete dei suggerimenti sull'algoritmo da
### seguire per produrre l'output corretto.
###

# I voti della seconda prova li devo mettere tutti nello standard output

# Poi devo mettere nello standard output i voti della prima prova
# ottenuti dagli studenti che non hanno un voto nella seconda prova

while read RIGA; do
    echo $RIGA
done <esame2.txt

echo stampo il primo esame

# STAMPA=0
# while read STUD VOTO; do
#     while read STUD2 VOTO2; do
#         if [[ $STUD == $STUD2 ]]; then
#             STAMPA=1
#         fi
#     done <esame2.txt
#
#     if [[ $STAMPA -eq 0 ]]; then
#         echo $STUD $VOTO
#     fi
#     STAMPA=0
# done <esame1.txt
#
# funziona ma e' terribile

while read STUD VOTO; do
    if [[ ! $(grep $STUD esame2.txt) ]]; then # se grep trova qualcosa da exit status 0
        # se non trova niente allora stampa
        echo $STUD $VOTO
    fi
done <esame1.txt
