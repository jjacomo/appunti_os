NOMIFILE=$(ls)
for NOME1 in $NOMIFILE; do
    for NOME2 in $NOMIFILE; do
        for NOME3 in $NOMIFILE; do
            echo "(${NOME1},${NOME2},${NOME3})"
        done
    done
done
