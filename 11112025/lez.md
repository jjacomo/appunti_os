# Ciao siamo a pag 148

ANCORA RIDIREZIONAMENTI

per ridirige lo stream N nello stream M fai
```bash
N>&M
```

ad esempio:

```bash
ls nonesiste.txt 2>&1
```
non scrive nello standard error ma nello standard output (in pratica stampa al terminale uguale)

* 1: stdout
* 2: stderr

altro esempio:

```bash
echo aiuto 1>&2
```


> [!WARNING]
>
>     >  e' diverso da  >&
>
>
>     > fa il ridirezionamento da stream a file:
>     N>nomefile
>
>     Ad esempio 2>1 manda lo stderr nel file chiamato "1"
>


---

## Es lancio uno script e voglio vedere solo i messaggi di errore (non l'output)

```bash
ls nonesiste.txt 1>miofile.txt
# manda l'output nel miofile.txt
# e quindi stampa solo lo stderr e non l'out
```
=> ancora meglio =>
```bash
ls nonesiste.txt 1>/dev/null
# manda l'output in un file speciale che fa praticamente da cestino
# e quindi stampa solo lo stderr e non l'out
```


---

## per ridirigere sia lo stderr che stdout nello stdin di un altro programma c'e' l'operatore `|&`

es:
```bash
ls pippo.txt |& grep such
```


### altro esempio

```bash
NUM=1
echo "${NUM}"

while (( "${NUM}" <= "3" )) ; do
    echo "${NUM}"
    ((NUM=${NUM}+1))
done > pippo.txt # ridireziona tutto, anche i comandi dentro la condizione del ciclo while

echo "${NUM}"
```

Dopo l'esecuzione dello script, nel file pippo.txt troveremo le 3 righe:
1
2
3
mentre a video vediamo le 2 righe
1
4


Se invece di `>` avessi messo `&>` avrebbe rediretto sia lo stdin che lo stdout in pippo.txt


---

## Adesso comando utile per eseguire script su macchine remote

`<<` ridireziona quello dentro la KEYWORD al comando prima

```bash
while read A B C ; do echo $B ; done <<FINE
uno due tre quattro
alfa beta gamma
gatto cane
FINE
echo ciao
```


<<FINE dice alla bash di guardare a tutte le righe fino alla parola specificata (che deve essere NECESSARIAMENTE all'inizio della riga) e usarle come input al comando prima.
Quindi ridireziona lo stdin.


ES voglio eseguire uno script locale in una macchina remota con ssh:
Se il mio script deve prendere in input un file della macchina remota posso mettere il contenuto del file da ridirezionare al mio script "dentro la parola FINE" come prima, cosi' mi evito delle gnacchere.
Serve per mettere dentro allo script sia i comandi sia l'input stesso incorporato.


NON STAVO ASCOLTANDO
Operatore `<<<` (ridireziona una sola parola)

---

## Raggruppamento di comandi

( comando1 ; comando2 ; comando3 ; ...) > out.txt


---

## Comandi simili (?)
Sono fatti per leggere da stdin e scrivere in stdout (Unica somiglianza).
Stdin puo' essere sostituito dal nome di un file.
Nascono per processare file di testo.


`head`, `tail`, `sed`, `cut`, `cat`, `grep` e poi `tee`.

Sono del pacchetto `core utils` (GNU coreutils).


```bash
head -n 3 file.txt # outputta le prime tre righe del file

tail -n 2 file.txt # outputta le ultime due righe del file
# cat file.txt | tail -n 2
```

`sed` applica delle trasformazioni alle righe che legge:
argomento e' quello che deve matchare (s (sostituisci) / (stringa da sostituire) / (sostituisci con)).
E lui sostituisce in ogni riga il match (solo la prima occorrenza della riga) (se vuoi sostituire TUTTE le occorrenze devi aggiungere alla fine g (global)) (m3u_prefix ....)

```bash
sed 's/DaSostituire/Rimpiazzo/'
sed 's/cane/gatto/g'
```


`cut` rimuove dei caratteri 

```bash
echo 123456789 | cut -b 3-5 # b guarda un BYTE alla volta (in questo caso un carattere) e prende i caratteri dal terzo al quinto, li rimuove e li stampa (stampa 345)
echo 123456789 | cut -c 3- # c guarda un CARATTERE alla volta (in questo caso stampa dal terzo in avanti)
echo 123456789 | cut -c -5 # (in questo caso stampa fino al quinto)
echo 123456789 | cut -c '-5,7-9,13' # si capisce dai
```


Questi programmi core utils sono i mattoncini per fare operazioni molto complesse quando messi insieme

## Variabile RANDOM
Valore compreso tra 0 e 65585
```bash
echo $RANDOM # stampa ogni volta un numero diverso
echo $(( $RANDOM % 6 )) # stampa un numero casuale tra 0 e 5
```

Se assegni un valore a random gli dai un seed iniziale;
E quindi rigenera la stessa sequenza;


---

ORA DOVRESTI FARE ESERCIZI Lezione 5 (devo finire ancora quelli della lezione 4)










