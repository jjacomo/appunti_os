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

processi zombie (?)

Siamo arrivati a slide p194


---

# 19/11/2025

Lezione in aula con ghini.


Ritorniamo a `wait`.
E' usato perche' il processo padre a volte vuole sapere l'exit status del processo figlio.
il processo zombie e' un processo figlio finito (morto) ma non ancora riconosciuto dal padre come morto (il padre e' acnora vivo) con la wait e quindi la memoria per le info sul processo e' ancora allocata ma il processo e' morto.
Viceversa se il processo padre finisce (muore) senza fare wait e quindi ha lasciato dei processi figli in giro questi diventano orfani e vengono adottati dal processo `init`. 
A volte il processo init chiama la wait per fare terminare i processi (?)

Il processo padre puo' non voler fare la wait perche' era difficile da programmare (cosi' di sicuro e' piu' semplice -0'ld').
Comunque della wait ne abbiamo gia' parlato con ferretti se ti ricordi.


## init

E' il primo processo lanciato dopo aver fatto il boot.
Fa partire i servizi, daemon, processi del sistema operativo, processo per il login dell'utente...


## Distro Linux

Linux Loader era il boot loader.
La gestione dei pacchetti era tutta manuale.
1995.
Nasce il concetto di interfaccia virtuale.

Dioca Ghini coi suoi amici al 2ndo anno ha progettato un sistema per aumentare la banda della rete dell'universita' (da 2mb a 30mb) sfruttando le antenne radio e il protocollo IP.

### Debian

Una delle prime, ha generato diverse derivate (tipo `Ubuntu`).
Una delle piu' stabili (per aggiungere un pacchetto lo controllano bene e ci mettono un po').
Gestore di pacchetti apt (ultimamente anche snapd).

### Red Hat 

E' diventato privato (lo hanno comprato).
Comunque roba seria...

### ROcky Linux

Versione ancora open di Red Hat (creata quando l'hanno comprata)

### Alpine Linux

Minimalissima, decidi tutto tu cosa metterci.
Utilissima quando vuoi mettere su roba nei container (e' molto leggera).
Gestore dei pacchetti apk (non e' il massimo).

### Gentoo

E' fuori di testa, ricompili sempre tutto quanto anche il kernel.
Ogni volta che fai un aggiornamento devi ricompilare tutto e quindi ci mette un casino.
Portage e' il packet manager.



## boot

### Fasi del boot

1. boot loader carica kernel (non tutto) e initramfs (initial RAM file system).

Il kernel linux non e' monolitico, non vengono caricati tutti i moduli subito, (moduli ad esempio driver (tipo del disco, finche' non li carica non puoi usare il disco)).
initramfs e' un mini filesystem dove ci sono informazioni essenziali sui moduli (per il disco?).

2. adesso il kernel puo' leggere dal file system e quindi caricare altra roba prendendola dalla memoria.
    Riconosce tutto l'hardware e poi lancia il processo init (che ha PID 1)

<!-- Da approfondire/finire -->


## Crittografia

Codifica: trasformare sequenze di byte in altre sequenze di byte.
Decodifica: tornare indietro.


Diversi tipi:
* A chiave segreta (simmetrica): sono abbastanza sicuri.
* A chiave pubblica (in realta' una pubblica e una privata, asimmetrica, RSA).
* A chiave privata: poco sicura.

Funzioni hash:
* SHA-2 (secure hash algorithm)
* SHA-3 
*


### chiave segreta.
Entrambe le persone che vogliono leggere il messaggio (mittente e destinatario) devono avere la stessa chiave segreta.
Infatti la chiave segreta e' usata sia per codificare che decodificare il messaggio.
Algoritmi Triple-DES, AES.
Piu' grande e' la chiave, maggiore e' la sicurezza.
Se io ho n utenti che vogliono comunicare con gli altri abbiamo bisogno di molte coppie di chiavi, per ogni coppia di utenti bisogna avere una chiave per fare comunicare i due utenti tra loro (sono davvero tante).


### chiave pubblica

Entrambe le chiavi possono essere usate per codificare/decodificare ma per fare l'altra operazione devi usare l'altra chiave.

```
PublicKey ( PrivateKey (text) ) = text
PrivateKey ( PublicKey (text) ) = text
```

Ogni utente ha la sua chiave privata che conosce SOLO lui.
Poi ha la sua pubblica che invece devono conoscere tutti.
Svantaggi: la codifica/decodifica e' molto piu' dispendiosa.
    Molto spesso infatti si usano metodi per non fare tutti i passaggi (decifrare solo una parte).


#### come funziona

Il mittente deve mandare al destinatario un testo cifrato che solo il destinatario e' in grado di decifrare.
Il mittente cifra il testo usando la chiave pubblica del destinatario.
Manda il messaggio e il gioco e' fatto.
Cio' garantisce la proprieta' di `segretezza`.

Se invece:
Il mittente cifra il testo usando la sua chiave privata.
Manda il messaggio e il destinatario decifra usando la chiave pubblica del mittente...
Ma cosi' ovviamente e' una cazzata, tutti possono decifrare il messaggio...
Pero' e' un metodo per garantire l'autenticazione del `mittente`, l'`integrita'` del messaggio e la sua `non repudiabilita'`.
Immagina infatti di essere il destinatario di suddetto messaggio, se scopri che usando la chiave pubblica di tizio1 viene un messaggio chiaro sensato allora sai che lui e' proprio chi pensavi che fosse.

Per avere tutte le proprieta' insieme si fondono le due tecniche insieme.
Guarda la slide a pag12.

Pro: non devi scambiarti chiavi segrete.


## Funzione hash
lo sai dai.

A volte si scambia il termine funzione checksum e funzione hash ma di base sono diverse.


## Firma digitale (tecnica MAC)
Introduzione_alla_crittografia.pdf su Virtuale.
Slide 20.
MAC - message authentication code.
Il problema delle cifrature con chiave asimmetrica e' che ci vuole trooooppo tempo.
E se non mi interessa la segretezza ma solo le altre 3 proprieta'? integrita' e autenticazione e non ripudiabilita'

* MAC: si usa la crittografia simmetrica normalissima.
* Firma digitale: crittografia asimmetrica

( Slides: Se MD() e' la funzione, MD(m) e' il digest )

Se riesci a decifrare il blocco del digest cifrato, non hai ancora la garanzia che il messaggio sia giusto ma che sia stato cifrato da alice si.
Si ricalcola anche il digest del messaggio che e' stato mandato insieme al digest.
Se i due digest combaciano allora sei sicuro anche della sicurezza del messaggio (che sia non modificato)


Solo che sta roba ha lo stesso problema delle chiavi simmetriche.
Servono un sacco di chiavi.
Come si fa col problema di repository di pacchetti software (tipo AUR) che devono mandare pacchetti e tutti quelli che li scaricano devono essere certi della loro autenticita'???
==>
## Firma digitale
Slide 21.

Il destinatario del messaggio deve conoscere la chiave pubblica del mittente.
Il mittente ha la sua chiave privata che usa per firmare e la pubblica per i destinatari che la useranno per confermare verificare l'autenticita' del messaggio.
Abbastanza simile a prima, guarda slides.
Molto piu' rapida de MAC.


## PGP e GPG signature
Ancora un altro meccanismo.
Gnu Privacy Guard.
Serve a garantire l'integrita' di un pacchetto software che viene distribuito da una repo di pacchetti.
E' molto efficace, verifica l'integrita' e l'autenticazione ma e' anche leggerina.
Oggi si usa GPG (e' open source), ma nasce prima PGP (Pretty good privacy) (non e' open source).
Molto spesso si scambiano i termini ma sono cose diverse.



