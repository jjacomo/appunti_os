# CIAO

* Ripasso comando history 

## COMPORTAMENTO SHELL IN BASE AGLI ARGOMENTI (OPZIONI)

`/bin/bash -c ./primo.sh` quel flag -c mi fa 
lanciare la shell in modalita' non interattiva 
(con il terminale).

Quando fai partire un nuovo terminale, crei una
nuova finestra su cui e' lanciato un interprete di
comandi (dell'utente) e che fa una serie di
operazioni per displayare sul terminale. Questa e'
una shell interattiva NON di login (mi fa lanciare
i comandi senza chiedermi l'autenticazione (il so
sa gia' che l'utente e' gia' autenticato))

La shell interattiva di login e' quella che ti
esce fuori quando booti un sistema linux senza
interfaccia grafica
QUando fai l'accesso poi questa shell fa una serie
di operazioni (leggendo dei file di configurazione
(degli script che vengono eseguiti in modalita'
SOURCE altrimenti sarebbero eseguiti in una shell
figlia e non si farebbe nulla) e cosi' configura
le variabili d'ambiente (alcuni di questi file
sono `/etc/profile`, dove ci sono alcune var 
d'ambiente fondamentali, poi nella dir dell'utente
vengono cercati `.bash_profile`, `.bash_login`, `.
profile` (in questo ordine (se esistono), viene
eseguito il primo che viene trovato e basta) )). 
Adesso hai una shell bash non di login che si
limita a lanciare infine il file `.bashrc` (che 
puo' essere modificato dall'utente)

A diA differenza della shell interattiva la shell
non interattiva non esegue nessuno dei file
listati primafferenza della shell interattiva la
shell non interattiva non esegue nessuno dei file
listati prima

## ESPANSIONI

* `echo -n ciao` mi scrive ciao senza andare a capo

* operatore `;` per separare i comandi e eseguirli 
in fila in un unica botta. 

* Come tutti i caratteri
speciali, possono essere disabilitati con il `\`,
oppure racchiudendolo con `""` o `''` (ma `""` non
disabilita tutti prova a fare `echo ciao
"$USER ;;;;;"`).

* espansione `{}`: `echo va{ffancu,acaga,ammori}lo`
stampa vaffanculo vaacagalo vaamorilo

* espansione `~`: e' il percorso della home dir 
dell'utente oppure se ne esiste un altro `~giorigo`
mi indica `/home/giorgio`

* espansioni `*`, `?`, `[..roba qui dentro..]`: 
servono a cercare nomi di file che esistono nel
mio filesystem. Il `*` ne sostituisce molti, il `?`
DEVE essere sostituito con un carattere, il `[abc]`
DEVE essere sostituito con 1 tra i caratteri dentro
le quadre. Nota che `*` puo' essere sostituito 
anche con la stringa vuota (gli altri no).
Le `[]` accettano anche un elenco fatto tipo cosi:
`[1-7]` oppure `[c-f]`=`[cdef]` eccetera. O 
addirittura si puo fare `[[:lower:]]` matcha tutte
le lettere minuscole.
Se sono in una directory indietro (esempio
`~robette_mie` posso fare anche
`echo */bop?.tidal` per cercare in tutte le 
sottodir un file che si chiama bop...

## COMANDI PER DIRECTORY
`mkdir nomedir` creo una directory

## ALTRO 
con `ls -l nomedir` ti stampa le info delle cose 
contenute in nomedir se vuoi le info di nomedir 
devi fare ls `ls -ld nomedir`.
La combo `ls -d */*/...` puo' essere comoda a volte

`ls -alhR` quell'R sta per ricorsione e quindi 
fa `ls -alh` per tutte le sottodir

`rm -rf nomedir` per eliminare dir non vuote senza 
chiedere conferma

`mv` per spostare o cambiare nome a file/dir

## DUE PAROLE SULL'AUTOCOMPLETAMENTO
`TAB`

## SCRIPT CHE ACCETTANO ARGOMENTI DA RIGA DI COMANDO
$# e' la var d'ambiente che dice il numero di 
argomenti passati allo script (argc);
$0 il nome del processo in esecuzione
$1 il primo argomento
$2 il secondo 
...
$* contiene tutti gli argomenti separati da spazio
$@ simile a $*

COOL

