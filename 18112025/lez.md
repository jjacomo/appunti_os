# INTRO 

tee, cut delimitatori, tail -f, processi, signal, wait.

la volta scorsa abbiamo parlato delle coreutils oggi continiuamo.
+ es Lezione5

## tee

```bash
./script.sh | tee out1.txt out2.txt
```

equivale a un ipotetico:

```bash
./script.sh 
            > out1.txt
            > out2.txt
```

cioe' script adesso stampa sia su terminale (come farebbe normalmente) che su tutti i file passati a tee

## tail -f

ricorda che tail ti fa vedere le ultime righe del file specificato:
```bash
tail -f out1.txt
```

con il flag -f tail rimane a guardare il file e stampa le righe che vengono aggiunte (da un processo/script).
Non termina finche' non premi ctrl+c.

## cut

```bash
cut -f 2-3 dati.txt
```

```bash
cut --delim="a" -f 2- dati.txt
```
divide le stringhe di ogni riga col carattere delimitatore "a" (?)



## sed (stream editor)

serve a trasformare le righe dei file (sostituzione)

```bash
sed 's/togli/metti' nomefile.txt
```

* s         sta per sostituisci
* togli     da matchare
* metti     rimpiazzo


```bash
sed 's/togli/metti/g' nomefile.txt # anche le occorrenze dopo la prima nella stessa riga
```

```bash
sed 's/^./metti' nomefile.txt # sostituisce il primo carattere di ogni riga
```

```bash
sed 's/.$/metti' nomefile.txt # sostituisce l'ultimo carattere di ogni riga 
```

```bash
sed 's/regex/metti' nomefile.txt # sostituisce la roba matchata dalla regex di ogni riga
```

con il flag `-i` non ti stampa la roba su terminale ma sovrascrive direttamente il file.
C'e' anche un flag che sovrascrive il file ma ti fa anche una copia del precedente per backup se hai fatto una cazzata.



## Processi
P 174.

```bash
ps # vedi i processi con i loro pid univoci
```

I pid sono un numero limitato (di solito almeno 65535)

```bash
echo $BASHPID
echo $$
# stampano entrambe il pid ma non sono veramente uguali guarda p174
# in poche parole $$ non capisce se si trova in una subshell
```

* `Processi`: Un processo è la più piccola unità di elaborazione completa ed
autonoma che può essere eseguita in un computer.
* è un insieme di thread di esecuzione operanti all'interno di
un contesto, il quale comprende uno spazio di indirizzamento in memoria
ed una tabella dei descrittori di file aperti per quel processo.
* `Gruppo di processi` (process group): Un processo può lanciare
l'esecuzione di altri processi: questi altri processi appartengono allo stesso
gruppo di processi del processo padre, a meno che non si svolgano azioni
che modificano il gruppo di appartenenza.
* `Terminale di controllo`: Un processo lanciato in esecuzione può avere un
"controlling terminal" (un terminale da cui è controllato, che è l'astrazione
di terminale (console=video+tastiera) da cui prende gli standard input
output ed error.
* `Terminale di controllo del gruppo di processi`: Un processo lanciato in
esecuzione eredita lo stesso "controlling terminal" dal padre che lo ha
lanciato, a meno che non si svolgano azioni che sganciano il processo dal
terminale di controllo. Quindi tutti i processi di uno stesso gruppo di
processi condividono lo stesso terminale di controllo.


Ogni terminale che hai aperto e' completamente separato da un altro, identifica una `sessione` e dei sottoprocessi (gruppo di processi che appartengono a quella sessione).

Se cade il terminale di controllo il sistema operativo ammazza la bash interattiva e tutti i processi sottostanti (lanciando un segnale `SIGHUP` (signal hang up)).
Per lanciare un processo (magari che dura molto) (utile per quando si esegue con ssh) che sopravviva questo omicidio esiste il comando `disown` che sgancia il processo dalla sessione che appartiene al terminale di controllo.
Disown funziona quando il processo era gia' stato lanciato, se vuoi lanciarlo direttamete sganciato proprio quando avvii il provesso c'e' il comando `nohup`.

### background foreground

```bash
./scriptcheeseguedeicomandiequindideiprocessi.sh
```
un processo puo' essere in foreground solo uno alla volta (usa il terminale di controllo).

```bash
./script.sh & # lo lancio in background
```
quindi mi rida' subito il prompt ma se il processo in background stampa in stdout me lo vedo lo stesso (pero' posso comunque eseguire altri comandi/processi).


Quando lanci un processo in background collegato a un terminale di controllo prende il nome di `job`.
A un job viene dato anche un altro identificatore.

$! contiene il pid dell'ultimo processo lanciato in background.

```bash
jobs # ti fa vedere i jobs correntemente in esecuzione
```

## robe 

```bash
^C # termina il processo in foreground
^Z # sospende il processo in foreground
fg # riprendere dopo ^Z in foreground
bg # riprendere dopo ^Z in background
fg %1 # riprendere dopo ^Z in foreground specificando l'identificatore del job (se ho piu' jobs fermi)
bg %1 # same
disown %1 # distacca il job (dopo averlo creato) dal gruppo di processi (finisce l'esecuzione anche se chiudo la shell)
nohup ./script.sh arg1 arg2 ... & # lancia il processo in background e staccato dal gruppo di processi. Di default poi mette l'output in nohup.out (man nohup)
```

## Segnali 
interruzione software con cui il so avvisa il processo che deve fare qualcosa:

* `^C`: termina il processo corrente
* `kill <pid>`: sto mandando SIGTERM (valore 15) (e' uguale a `kill -SIGTERM <pid>` o `kill -15 <pid>`), ma il processo puo' anche non accettarlo (se configurato per non farlo).
* `kill -9 <pid>`: lo ammazza per forza (equivale a `kill -SIGKILL <pid>` o `kill -KILL <pid>`)
* `kill -SIGTSTP <pid>`: e' l'equivalente di ^Z per sospendere il processo
* `kill -l`: ti lista i messaggi che puoi usare e il loro numero.

Gli script possono ricevere segnali e fare cose di conseguenza:
=>
### trap

```bash
trap "echo \"ricevuto SIGUSR1 !!! Termino !!!\"; exit 99" SIGUSR1
# quando la shell corrente (lo script che e' in esecuzione deve eseguire quel comando quando riceve il segnale SIGUSR1)
while true ; do echo -n "."; sleep 1; done # senno termina e non ho tempo di mandare il messaggio
```


### funzioni bash

```bash
# script.sh
ricevutoSIGUSR2() {
    echo "ricevuto SIGUSR2, continuo";
}
trap ricevutoSIGUSR2 SIGUSR2 # esegue la funzione ricevutoSIGUSR2 quando arriva il segnale SIGUSR2

while true ; do echo -n "."; sleep 1; done
```

```bash
# lancia_script.sh
./script.sh &
CHILDPID=$!
sleep 5 ; echo "mando SIGUSR2"; kill -s SIGUSR2 ${CHILDPID}
sleep 5 ; echo "mando SIGUSR2"; kill -s SIGUSR2 ${CHILDPID}
sleep 5; echo "mando SIGUSR1"; kill -s SIGUSR1 ${CHILDPID}
sleep 4;
```

Cosi' i processi possono comunicare


## comando Wait

comando con cui il processo padre aspetta la terminazione del figlio

```bash
program.exe arg1 arg2 arg3 .... argN &
PIDsalvato=$!
echo "il PID di program.exe e\' ${PIDsalvato} "
# ... faccio qualcosa d'altro ...
wait ${PIDsalvato} # attende la terminazione di program.exe
```

Siamo arrivati a slide p194
