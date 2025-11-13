# CIAO

## Espressioni condizionali

slide 108 InterfacciaUtenteACaratteri.pdf

`$?` E' una variabile d'ambiente che cattura il risultato di un programma chiamato da uno script

- `!`     NOT
- `&&`    AND
- `||`    OR

si scrive cosi'

``` bash

[[ ( (condA)&&(condB) ) || condC ]]
# le tonde servono per dare l'ordine di esecuzione
```

`[[]]` supportano la valutazione aritmetica all'interno, quelle singole no
(tra l'altro prima c'era un altra sintassi con [] o 'test', ma hanno dei problemini, ergo usa sempre [[]]).
Returnano 0 (true) o != 0 (false).

Gli spazi servono perche' altrimenti alla shell sembra un unico comando

operatore `-e` <nomefile>":
returna 0 se il file non esiste?
operatore `-d` <nomedir>":
returna 0 se la dir non esiste?
operatore <nomefile> `-nt` <nomefile>":
confronta le date di ultima modifica
operatore `-r` <nomefile>:
ti dice se o user corrente ha il permesso di lettura
e molti altri...

dentro le espressioni condizionali si possono usare le espansioni per le variabili


### scarrellata di operatori:

* aritm   lessicografici
* -eq   =
* -ne   !=
* -le   <=
* -lt   <
* -ge   >
* -gt   >=

gli operatori <, =, ... fanno i confronti lessicografici in ASCII

es
``` bash
[[ 3 -le 5 ]]

echo $?
```

stampa 0 (vero)
(falso e' 1)

* Operatore -z <stringa>: 
  da 0 (true) se la stringa ha lunghezza 0 (quindi in sostanza ci chiediamo se la variabile esiste)

es.
``` bash
#non ho creato NUM
[[ -z $NUM ]]
echo $?
#stampa 0
```

Analogamente -n <stringa>:
da 0 se la stringa e' piu' lunga di 0 (non e' vuota)


### COndizioni su file

`-d` file       True if file exists and is a directory.
`-e` file       True if file exists.
`-f` file       True if file exists and is a regular file.
`-h` file       True if file exists and is a symbolic link.
`-r` file       True if file exists and is readable.
`-s` file       True if file exists and has a size greater than zero.
`-t` fd         True if file descriptor fd is open and refers to a terminal.
`-w` file       True if file exists and is writable.
`-x` file       True if file exists and is executable.
`-O` file       True if file exists and is owned by the effective user id.
`-G` file       True if file exists and is owned by the effective group id.
`-L` file       True if file exists and is a symbolic link. (deprecated, see -h)

---

### ESEMPI

``` bash
[[ -n $(name) && -e $(name) ]]
if (( $? == 0 )) ; then
    echo "esiste $(name), lo elimino";
    rm -f $(name)
fi ;
```

analogamente

``` bash
if [[ -n $(name) && -e $(name) ]] ; then
    echo "esiste $(name), lo elimino";
    rm -f $(name)
fi ;
```
meglio questa direi

### ALTRO 

``` bash
NUM=123
echo ${#NUM}
#stampa la lunghezza della variabile (in questo caso 3)
```

- env | more   ti fa vedere le variabili d'ambiente

``` bash
if [[ -e prova.c ]] && gcc -o prova.exe prova.c ; then echo "compilato"
fi
```
in questo caso && fa il comando condizionale

---
---
# LEZIONE IN AULA CON GHINI (29/10/2025)
## PAROLE

Una parola e' una stringa separata in caratteri separatori;
il concetto di parola dipende dal concetto di separatore di parola:
\n, ' ', \t...

La bash definisce i caratteri separatori ha una var d'ambiente (`IFS=$' \t\n'`).
(puoi guardarla con `set | grep IFS`)

```bash
$'caratteridellaparola'
```

Definisce delle sequenze di caratteri tra cui caratteri speciali (ci puoi mettere tipo \n credo)

A volte puo' essere comodo cambiare la variabile IFS.

--- 
## LETTURA DA STDIN (O FILE)

Le letture dipendono dal concetto di parola.

```bash
read RIGA
```
Il comando read (se non specifichiamo altre opzioni) legge tutto cio' che hai scritto nella tastiera (stdin) e la mette dentro una variabile (o piu'). E' come una scanf.
Se da' exit status 0 (guardi con echo $?) vuol dire che non ha letto tutto l'stdin (cioe' che stdin puo' ancora dare altri dati). Infatti se invece di invio (andata a capo) premi `ctrl+d` (chiudi stdin per il processo corrente) da exit status 1 (ha letto tutto stdin).

```bash

while true ; do 
    # read RIGA
    # if (( "$?" != 0 ))
    if (( (read RIGA) != 0 ))
    then 
        echo "eof not reached"
        break
    else 
        echo "read \"$(RIGA)\""
    fi
done
```

Attenzione potresti perdere l'ultima riga cosi'

```bash

# while read RIGA ; [[ $? -eq 0 || $(RIGA) > 0 ]] ; do  MA E' SBAGLIATO NO??
while read RIGA ; [[ $? -eq 0 ]] ; do 
    echo "read \"$(RIGA)\""
done
```


```bash
read VARA VARB VARC
```
Se scrivo tre parole la prima viene messa in VARA, la seconda in VARB e cosi' via.
Se hai piu' parole in input la prima viene comunque messa in VARA, la seconda in VARB e tutto il resto in VARC.
Se hai meno parole invece le variabili finali saranno vuote


```bash
read -n 4 STRINGALUNGA4NO\n
```

legge 4 caratteri alla volta (anche spazi e tutto il resto (apparte andata a capo)).

mi sono un attimo perso cos'e' che e' exec 103<&-

```bash
read -N 4 STRINGALUNGA4
```

legge 4 caratteri alla volta (anche spazi e tutto il resto).

il parametro `-u` ?? (per scegliere il file ?)

## FILE 

<!-- APERTURA: -->
<!-- `exec fd>&-` -->
<!-- CHIUSURA: -->
<!-- `exec fd>&-` -->

Quando apri un file, devi specificare in che modo aprirlo (lettura/scrittura/append/lettura+scrittura).
* SOLO LETTURA          `exec n<  path/to/file`
* SCRITTURA             `exec n>  path/to/file`
* APPEND                `exec n>> path/to/file`
* LETTURA E SCRITTURA   `exec n<> path/to/file`

n e' l'id scelto dall'utente (file descriptor)
Se non vuoi scegliere te il file descriptor (per evitare conflitti e fare casini)
sostituisci n con (NomeVar)
`exec (NomeVar)<  path/to/file`
adesso l'os sceglie e in NomeVar trovi il file descriptor che ha scelto

in `/proc` esiste una dir per ogni processo e dentro a questa c'e' n'e' un'altra `fd` che contiene il file descriptor. 

---
## RIDIZIONAMENTI DI STREAM


```bash

IFS=$';\n'
while read P1 P2 P3; do echo $P2; done <input.txt
```

lancio un comando (che eseguira' il processo figlio ma il padre gli manda una tabella (file descriptor) modificata che punta a un altro stream).
Ma c'e' anche un altro modo (che non ho capito (il padre modifica la sua stessa tabella?))

Ridizionamenti:
* `<`       ricevere input da file
* `>`       mandare output a file (eliminando quello che c'era prima)
* `>>`      mandare output a file (appendendo)
* ``       ricevere input da file

