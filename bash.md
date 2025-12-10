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
* `[1-7]` puo’ essere sostituito da un solo carattere tra 1 2 3 4 5 6 oppure 7.
* `[c-f]` puo’ essere sostituito da un solo carattere tra c d e oppure f.
* `[[:digit:]]` puo’ essere sostituito da un solo carattere numerico (una cifra).
* `[[:upper:]]` puo’ essere sostituito da un solo carattere maiuscolo.
* `[[:lower:]]` puo’ essere sostituito da un solo carattere minuscolo.

---

## Parameter expansion


