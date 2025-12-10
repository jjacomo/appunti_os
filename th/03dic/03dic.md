# INTRO

Oggi esercizi su caricamento della memoria, e poi cambiamo argomento.
Ultima parte del corso.
La prossima settimana e' l'ultima.
Faremo accenni sulla sicurezza.

paginazione, segmentazione, memoria virtuale....


## ESERCIZIO

Pag.122
Si consideri la seguente sequenza di riferimenti di memoria,
nel caso di un programma di 490 parole (word)
10, 132, 250, 320, 25, 110, 480, 28, 132, 250, 370, 485.

* si determini la stringa di riferimenti delle pagine, supponendo
che la dimensione delle pagine sia di 100 parole.

Memoria Logica:

|`pagine` |1|2|3|4|5| 
|---|---|---|---|---|---|
|`word`|fino a 100|da 100 a 200|a 300|400|500|



* Quante page fault si verificheranno se assumiamo una politica
di rimpiazzamento FIFO con 3 blocchi fisici? E con 4 blocchi?

con tre blocchi sono 9

|`blocchi` |
|-|
|1| 
|-|
|.|
|-|
| . |   fa caricament

|`blocchi` |
|---|
|  1|

Rimpiazzo ogni volta il primo che avevo messo

* quante page fault si verificheranno se assumiamo una politica
di rimpiazzamento ottimo con 3 blocchi fisici? E con 4 blocchi?

Rimpiazzo ogni volta quello che mi servira' piu' tardi (lo vedo nella sequenza (guardando nel futuro))
DAI MA E' STRA EASY


## ESERCIZIO 2

Pag128
Lo stesso ma con algoritmo LRU (least recently used)
Sostituisco la pagina che non uso da piu' tempo.
E' NA STRONZATA PURE QUESTO.


E per la prima ora abbiamo fatto....
Mamma mia che coglione...


# SICUREZZA

L'asimmetrica serve per:
* verificare l’identità del server (certificati) (o un utente)
* scambiarsi un segreto iniziale in modo sicuro
* avviare una sessione

Quando “usi Internet” in modo sicuro (HTTPS):

Il tuo device parla col server usando RSA/ECC (asimmetrica) per scambiarsi una chiave.
Da quel momento usano solo AES o ChaCha20 (simmetrica) per cifrare tutto il traffico.
Questo è il cuore della sicurezza moderna su Internet.

## chiave pubblica (asimmetrica)
Molto discorsivo, ora sta parlando di crittografia.
Ogni utente linux puo' creare una coppia di chiavi, 1 pubblica e 1 privata.
Alice vuole mandare -> privata Alice -> pubblica Bob -> internet -> priv Bob -> pub Ali -> Bob puo' leggere

In questo modo Bob e' sicuro che sia il messaggio sia di alice e che nessuno lo abbia letto


# 10/12/2025

Mamma mia sono le lezioni piu' inutili dell'universo.

