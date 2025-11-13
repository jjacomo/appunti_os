echo "sono lo script2:"

for ((i = $#; $i > 0; i = $i - 1)); do
    echo "${!i}"
done
