# TUTTO SU BASH (bourne again shell)

---

### Interesting
POSIX: Portable Operating System Interface for Unix)
nel IEEE 1003.1 (POSIX.1) si definiscono le sistem call (le API) per i software realizzati per UNIX.
in POSIX.2: introdotte shell e utility;
...
Librerie C


---

# INIZIO VERO

# Espansioni

* `history` expansion                       !123
* `brace` expansion                        a{damn,czk,bubu}e
* `tilde` expansion                        ~/nomedirectory
* `parameter` and variable expansion       $1 $? $! ${var}
* `arithmetic` expansion                   $(( ))
* `command` substitution                   (effettuata da sinistra verso destra) ` ` $( )
* `word` splitting
* `pathname` expansion                     * ? [...]
* `quote` removal                          rimuove unquoted \ ' " non generate dalle precedenti espansioni


## Variable Expansion

```bash
${ nome_della_variabile } # se poi dopo il carattere '}' 
                          # ci sono spazi bianchi puoi anche solo scrivere:
$nome_della_variabile
```

### Operatore ${!

```bash
varA=pippo
nomevar=varA
echo ${!nomevar} # stampa a video pippo
```

### Operatore ${#

``` bash
NUM=123
echo ${#NUM}
#stampa la lunghezza della variabile (in questo caso 3)
```

### PATH VARIABLE

La variabile PATH contiene una sequenza di percorsi assoluti nel filesystem di
alcune directory in cui sono contenuti gli eseguibili

---

##### CHOWN

Quando un utente crea un file, il s.o. assegna l’utente come proprietario del file.
Il proprietario/creatore poi può cambiare il proprietario del file con il comando:

```bash
chown nuovoproprietario nomefile
```

##### CHMOD

cambiare i permessi di un file (ez)

---

## Subshell (var locali e d'ambiente)

IMPORTANTE: Una subshell viene creata in caso di:
- Esecuzione di comandi raggruppati (vedi dopo).
- Esecuzione di script.
- Esecuzione di processo in background (vedi dopo).

- NB: l’esecuzione di un comando built-in avviene nella stessa shell padre

Ogni shell supporta due tipi di variabili
`Variabili locali`:
    Non “trasmesse” da una shell alle subshell da essa create
    Utilizzate per computazioni locali all’interno di uno script
`Variabili di ambiente`:
    “Trasmesse” dalla shell alle subshell.
    Viene creata una copia della variabile per la subshell.
    Se la subshell modifica la sua copia della variabile,
    la variabile originale nella shell non cambia.


Quando dichiaro una variabile con la sintassi già vista dichiaro una variabile `LOCALE`.
```bash
nomevariabile=ValoreVariabile
```

Per trasformare una variabile locale già dichiarata in una variabile di ambiente, devo
usare il comando `export` (notare che non uso il $ )
```bash
export nomevariabile
```

Posso anche creare una variabile dichiarandola subito di ambiente
```bash
export nomevariabile=ValoreVariabile
```


### Script execution senza subshell

```bash
source nomescript
```

### creazione di variabili d'ambiente da passare a subshell

```bash
VAR="pippo" ./ciao.sh
# adesso ciao nel suo ambiente di esecuzione ha anche VAR
```

##### UNSET

```bash
# Posso eliminare una variabile esistente (vuota o no) col comando unset
unset nomevariabile
```

##### ENV e SET

```bash
env # visualizza l'elenco delle variabili d'ambiente (ENVironment)

set # ti fa vedere le var d'ambiente, locali e funzioni
# set lanciato con dei parametri serve a settare o resettare una opzione di
# comportamento della shell in cui viene lanciato.
# Ad esempio
set +o history # disabilita la memorizzazione di ulteriori comandi eseguiti nel file di
# history. I comandi lanciati prima della disabilitazione rimangono nel file di history.
set -o history # abilita la memorizzazione dei comandi eseguiti mettendoli nel file di
# history.
set -a # causa il fatto che le variabili create o modificate vengono immediatamente fatte
# diventare variabili d’ambiente e vengono ereditate dalle eventuali shell figlie.
set +a # causa il fatto che le variabili create sono variabili locali. E' il modo di default.
```

---

## History Expansion

```bash
history # stampa tutta la history dei comandi della shell corrente
# se faccio !numero mi lancia il comando associato a quel numero quando fai history
# se faccio !iniziocomandogiafatto mi lancia il comando che inizia con quelle lettere
```

---

### Separatore di comandi ;

```bash
echo pippo ; echo lol
```

### Delimitatore di comandi

```bash
echo "pippo ; echo " ; echo lol
# oppure
echo pippo \; echo

# Esiste anche il delimitatore ''
```

---

## Brace Expansion

```bash
echo va{acaga,ffancu,ammori,catihafat}lo
# il comando viene espando in questo modo
echo vaacagalo vaffanculo vaammorilo vacatihafatlo
```

```bash
# E' possibile inserire delle brace expansion all'interno di altri ordini di brace expansion.
# Il comando:
echo /usr/{ucb/{ex,edit},lib/{bin,sbin}}
# ottiene questo output:
# /usr/ucb/ex /usr/ucb/edit /usr/lib/bin /usr/lib/sbin
```

```bash
# Variabili nelle brace expansion
# E' possibile inserire delle variabili negli ordini di brace expansion
# all'interno di altri ordini di brace
A=bin
B=log
C=boot
echo ${A}{${B}${C},${C},${A}${B}}a
# visualizza
# binlogboota binboota binbinloga
```

### Generazione stringhe

```bash
# Il comando 
echo a{b..k}m
# ottiene questo output abm acm adm aem afm agm ahm aim ajm akm

# Il comando 
echo a{4..7}m
# ottiene questo output a4m a5m a6m a7m

# E' possibile annidare queste sequence expression all'interno di brace expansion
# annidate
# Il comando 
echo a{b,c{4..7}}m
# ottiene questo output abm ac4m ac5m ac6m ac7m
```

##### WildCards []

Ci sono anche `*`, `?` ma li sai gia'. 

* `[abk]` puo’ essere sostituito da un solo carattere tra a b oppure k.
* `[1-7]` puo’ essere sostituito da un solo carattere tra 1 2 3 4 5 6 oppure 7. `[c-f]` puo’ essere sostituito da un solo carattere tra c d e oppure f. `[[:digit:]]` puo’ essere sostituito da un solo carattere numerico (una cifra).
* `[[:upper:]]` puo’ essere sostituito da un solo carattere maiuscolo.
* `[[:lower:]]` puo’ essere sostituito da un solo carattere minuscolo.

---

## Parameter expansion

- `$#`  il numero di argomenti passati allo script
- `$0`  il nome del processo in esecuzione
- `$1`  il primo argomento, $2 il secondo...
- `$*`  tutti gli argomenti concatenati separati da spazi
- `$@`  come $* ma se quotato gli argomenti vengono quotati separatamente

- `$?`  l'exit status dell'ultimo comando eseguito ( 0 = SUCCESS, 1-255 ERROR )

#### FINEZZA
```bash
for name in $*; do
    echo $name
done
```

attento che cosi' se passi gli argomenti: "trota salmone" sgombro
che pensi che sarebbero 2 (e lo sono) il for ne vede 3
(i doppi apici vengono rimossi!!)

attento a non fare
for name in "$*" ...
cosi' vede sono un unico name bello lungo (e' un unica stringa)
PERO' PUOI FARE
for name in "$@" ...
e cosi' funziona anche se metti degli input tra doppi apici
funziona perche' $@ in realta' e' un vettore e quando lo
scrivo tra apici doppi mi quota dentro gli apici ogni casella
del vettore!


---

## Operatori (()) e $(()) (Arithmetic expansion)

- `(())`   valuta le espressioni aritmetiche al suo interno
    ```bash
    (( NUM=3+2))
    ```

    Assegna 5 alla variabile NUM

- `$(())`  e' come (()) ma puo' essere usato in una parte della riga di comando 
         e non tutta come richiede (())

Puoi fare:
* aritmetica: `+`, `-`, `*`, `/`, `%`.
* assegmaneti
* usare () per accorpare

POSSO ESSERE UTILIZZATE COME CONDIZIONE DI WHILE, IF E FOR

```bash
if (( 5 >= 2 )) ; then
    echo questo viene stampato
fi
```

---

## File Descriptors

Il file descriptor è un'astrazione per permettere l'accesso ai file.
Ogni file descriptor e’ rappresentato da un integer.

Ogni processo ha la propria `file descriptor table` che contiene (indirettamente) le
informazioni sui file attualmente utilizzati (aperti) dal processo stesso. In particolare, la file
descriptor table contiene un file descriptor (un intero) per ciascun file usato dal processo.
Per ciascuno di questi file descriptor, la tabella del processo punta ad una tabella di sistema
che contiene le informazioni sui tutti i file attualmente aperti dal processo stesso

Quando un programma entra in esecuzione l'ambiente del sistema operativo si incarica
di aprire 3 flussi di dati standard, che sono:

* `STANDARD INPUT` (stdin) serve per l'input normale (per default da tastiera). Viene
identificato da una costante valore numerico `0`.
* `STANDARD OUTPUT` (stdout) serve per l'output normale (per default su schermo
video). Viene identificato da una costante valore numerico `1`.
* `STANDARD ERROR` (stderr) serve per l'output che serve a comunicare messaggi di
errore all'utente (per default anche questo su schermo video). Viene identificato da
una costante valore numerico `2`

Una shell B figlia di una shell padre A (e in generale, un processo B figlio di un
processo A) `eredita una copia` della tabella dei file aperti del padre, quindi padre e
figlio leggono e scrivono sugli stessi stream.

---

## Command Substitution

```bash
OUT=$( ./bob.sh )
# in out ci finisce l'output di bob.sh
```

---

## Espressioni Condizionali

Ciascuna espressione condizionale si scrive mettendo le condizioni da valutare tra
doppie parentesi quadre `[[ .... ]]`.
Queste restituiscono un valore o 0 (vero) o 1 (falso)


- `!`     NOT
- `&&`    AND
- `||`    OR

si scrive cosi'

``` bash

[[ ( (condA)&&(condB) ) || condC ]]
# le tonde servono per dare l'ordine di esecuzione
```

supporta la valutazione aritmetica.

Un po' di operatori:
operatore `-e` <nomefile>":
returna 0 se il file non esiste?
operatore `-d` <nomedir>":
returna 0 se la dir non esiste?
operatore <nomefile> `-nt` <nomefile>":
confronta le date di ultima modifica
operatore `-r` <nomefile>:
ti dice se o user corrente ha il permesso di lettura
e molti altri...


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

* Operatore `-z` <stringa>: 
  da 0 (true) se la stringa ha lunghezza 0 (quindi in sostanza ci chiediamo se la variabile esiste)

es.
``` bash
#non ho creato NUM
[[ -z $NUM ]]
echo $?
#stampa 0
```

Analogamente `-n` <stringa>:
da 0 se la stringa e' piu' lunga di 0 (non e' vuota)


### Condizioni su file

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


es
``` bash
if [[ -n $(name) && -e $(name) ]] ; then
    echo "esiste $(name), lo elimino";
    rm -f $(name)
fi ;
```

---

## Lettura da stdin (read)

```bash
read RIGA
```




