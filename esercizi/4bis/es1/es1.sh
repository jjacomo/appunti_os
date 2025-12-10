# In una propria directory, creare 10 directory avente nome
# 1.0 1.1 1.2 1.3 1.4 ...... 1.9
# Utilizzare il comando for ed il comando mv della bash, per cambiare i nomi delle
# directory rispettivamente in :
# 2.0 2.1 2.2 2.3 2.4 ...... 2.9
# Suggerimento:guardare le slide su bash scripting, dove si parla di Estrazione di
# sottostringhe da variabili.

for (( i=0 ; $i < 10 ; i=$i + 1 )) ; do
	mkdir "1.${i}"
done
echo sleeping for 5 seconds, check directories
sleep 5
for (( i=0 ; $i < 10 ; i=$i + 1 )) ; do
	mv "1.${i}" "2.${i}"
done
echo changed names
