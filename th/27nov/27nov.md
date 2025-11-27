# INTRO 
PAG 46 direi.
torniamo con ferretti !!!

Oggi memoria

## Paginazione

E' divisa in pagine.
Ogni processo puo' avere assegnate 1 o piu' pagine anche non contigue.
Poi c'e' la tabella della memoria che associa a ogni pagina un indirizzo di memoria (un frame?).

Quanto grandi le pagine?
di solito 1kb, 2kb, 4kb.

Dove memorizzare la tabella delle pagine?

### TLB

TLB (?) e' un hardware fatto apposta che dato in input una chiave (ad esempio il numero della pagina che vuoi) ti da il frame della pagina. Essendo un componente molto costoso, e' tipo una cache di pagine, non vengono salvate tutte le pagine ma solo quelle piu' hot.
Se la pagina non e' presente nel TLB fai come un cache miss (TLB miss)

---

## Segmentazione

la memoria di un processo ha 3 tipologie di dati:
* aree text: contengono eseguibili, di solito solo lettura, condivisibili tra piu' processi
* aree dati:
* aree stack: non condivise, per l'esecuzione dei programmi


La segmentazione ci permette di dividere la memoria in questi 3 tipi.
L'area di memoria dedicata a un processo e' suddivisa in segmenti.
Ogni segmento mantiene informazioni omogenee. 
Ogni segmento puo' avere dimensione diversa, tipicamente 64kb-1mb

---

## Memoria Virtuale

Babaoglu e' colui che implemento' per primo i sistemi di Memoria Virtuale nei sistemi Unix.
Quando devi riempire tanta memoria con un sacco di processi diversi rischi di finirla!!!
Allora si e' pensato di fare cosi', quando un processo non sta eseguendo sposta la sua memoria dalla RAM al disco fisso e ricaricala quando ti servira'.
E' l'area di SWAP!!!!
Incredibile, io ci ho messo 16gb.

* permette di eseguire in concorrenza processi che nel loro
complesso (o anche singolarmente) hanno necessità di memoria
maggiore di quella disponibile

* la memoria virtuale può diminuire le prestazioni di un sistema
se implementata (e usata) nel modo sbagliato

Cio' funziona perche':
non è necessario che l'intero spazio di indirizzamento logico di un processo sia in memoria infatti:
i processi non utilizzano tutto il loro spazio di indirizzamento contemporaneamente.

### Implementazione

ogni processo ha accesso ad uno spazio di indirizzamento virtuale che può essere più grande di quello fisico
* gli indirizzi virtuali
    ■ possono essere mappati su indirizzi fisici della memoria principale
    ■ oppure, possono essere mappati su memoria secondaria
* in caso di accesso ad indirizzi virtuali mappati in memoria
secondaria:
    ■ i dati associati vengono trasferiti in memoria principale
    ■ se la memoria è piena, si sposta in memoria secondaria i dati contenuti in memoria principale che sono considerati meno utili

Paginazione a richiesta (`demand paging`)
* si utilizza la tecnica della paginazione, ammettendo però che alcune pagine possano essere in memoria secondaria.

Nella tabella delle pagine
* si utilizza un bit (v, per valid) che indica se la pagina è presente in memoria centrale oppure no.

C'e' il modulo "Pager" del sistema operativo che si occupa di caricare la pagina mancante in memoria, e di aggiornare di conseguenza la tabella delle pagine.


### politiche di rimpiazzameto

quando e' necessario liberare un frame (per metterlo in memoria secondaria) in che modo lo faccio?

#### FIFO

Viene segnato come vittima (il frame da rimpiazzare) il primo frame che era stato messo (che c'e' da piu' tempo) (quello piu' vecchio).

Non e' particolarmente efficente, magari tolgo dei frame che mi sarebbero serviti molto.


#### MIN

Sarebbe l'algoritmo ottimale ma per implementarlo dovresti predirre il futuro.
Infatti seleziona come vittima la pagina che sara' (impossibile saperlo) meno usata in futuro.


#### LRU

seleziona come pagina vittima la pagina che è stata usata meno recentemente nel passato.
E' basato sul presupposto che la distanza tra due riferimenti successivi alla stessa pagina non vari eccessivamente.
Stima la distanza nel futuro utilizzando la distanza nel passato.


Modo per approssimare LRU: Additional-reference-bit-algorithm

Second chance algoritm:
Ogni volta che uso una pagina metto un bit di controllo a 1. L'algoritmo di rimpiazzamento cicla tutte le pagine e vede quelle che non sono messe a 1 e le rimpiazza, poi aspetta per vedere le pagine che vengono rimesse a 1 e poi continua cosi'.


### Trashing

E' il fatto di impiegare piu' tempo a rimpiazzare processi che effettivamente farli runnare.

C'e' una treshold di processi in esecuzione che a una certa se ne aggiungi altri non viene piu' sfruttata meglio la cpu (ad eseguire piu' processi contemporaneamente) ma viene impiegato piu' tempo a scrivere e leggere dal disco e quindi la CPU sta ferma.


### working set 
NON LO FACCIAMO






