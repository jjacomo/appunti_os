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


