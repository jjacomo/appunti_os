# for CHAR in {c..g}; do
#     for FILE in /usr/include/?${CHAR}*; do
#         if [[ ${#FILE} -lt 18 || ${#FILE} -gt 23 ]]; then
#             echo $FILE
#         fi
#     done
# done
#
for CHAR in {c..g}; do
    for FILE in /usr/include/?${CHAR}*; do
        if [[ -e ${FILE} && (${#FILE} -lt 18 || ${#FILE} -gt 23) ]]; then
            echo $FILE
        fi
    done
done

# Quell' -e serve ad accertarsi che il file esista: se fallisce l'espansione
# di quei caratteri (perche' il file non esiste) mi stampa spazzatura
