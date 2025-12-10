# In una propria directory, creare 10 directory avente nome
# 1.0 1.1 1.2 1.3 1.4 ...... 1.9
# Utilizzare il comando for ed il comando mv della bash, per cambiare i nomi delle
# directory rispettivamente in
# 2.9 2.8 2.7 2.6 2.5 ...... 2.0
# Notare che, ad esempio, 1.1 deve diventare 2.8 e 1.3 deve diventare 2.6
# In generale, 1.X deve diventare 2.(9-X)


for (( i=0 ; $i < 10 ; i=$i + 1 )) ; do
	mkdir "1.${i}"
done
echo sleeping for 5 seconds, check directories
sleep 5
for (( i=0 ; $i < 10 ; i=$i + 1 )) ; do
	i2=$((9-$i))
	echo "1.${i} ==> 2.${i2}"
	mv "1.${i}" "2.${i2}"
done
echo changed names

