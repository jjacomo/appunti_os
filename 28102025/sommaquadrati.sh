STR=""
RIS=0
for NUM in $*; do
    ((RIS = RIS + NUM * NUM))
done

echo $RIS
