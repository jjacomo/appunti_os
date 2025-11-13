# CIAO 

se fai il comando bash dentro una bash si crea
una bash figlia (subshell) 
che e' una copia del padre, infatti se fai 
ps adesso vedi due processi che si chiamano 
bash. Poi puoi fare exit per uscire dalla figlia.

whoami ti dice chi e' l'utente 

## PASSWORD E SUDO
prova a fare `cat /etc/passwd` e ti stampa tutti 
gli utenti. Alla riga jacomo vedi il suo uid. 

in /etc/passwd pero' non sono piu' mantenute le 
password, quelle sono mantenute in /etc/shadow. 
Per vederle lo stesso fai sudo (sudu, ossia 
superuser do) cat /etc/shadow. Alla riga jacomo 
non c'e' proprio la password in chiaro ma una 
codifica ascii della password. Il sistema per 
verificare la password che hai messo la codifica 
con una hash e la confronta con quella che e' 
contenuta in /etc/shadow. 

Non tutti gli utenti possono usare sudo, lo 
possono fare solo gli utenti che appartengono al 
gruppo sudo. L'amministratore di sistema decide 
chi sono gli utenti che possono usare sudo. 
Per vedere chi appartienen a questo gruppo lo 
trovi in /etc/group. Qui ogni riga rappresenta un 
gruppo con affianco chi vi appartiente. Guarda 
chi e' in sudo. ATTENZIONE: in alcune distro 
non e' salvato li ma potrebbe essere in 
/etc/sudoers (sudoers.d)

C'e' un'altro file interessante `/usr/bin/passwd` 
che se lo esegui si crea un nuovo processo 
(il cui proprietario e' chi lo ha eseguito) 
che modifica il file /etc/shadow... Ma l'utente 
non potrebbe!! Pero' c'e' un trucco, il processo 
lanciato dell'utente in realta' ne lancia un'altro 
che e' proprieta' di root! Questa cosa si capisce 
dalla s al posto della x quando fai ls -l.

## SUBSHELL E VARIABILI

Quando crei una subshell si crea una copia ma 
vengono copiate solo le VARIABILI D'AMBIENTE e 
non le LOCALI. 
Quando modifichi le variabili d'ambiente in una 
subshell si modificano le copie, non le originali.
Le variabili d'ambiente tipiche sono $HOME, $PATH,
$USER. 
Quando esegui uno script me lo runna in una subshell. 
Ma se vuoi puoi farlo anche nella shell 
senza crearne un altra. Per farlo puoi usare il 
comando `source scripteseguibile.sh`. A volte 
puo' servire. Ma stai attento ad esempio se hai 
messo un exit nello script cosi' ti esce dalla 
shell, invece non lo avrebbe fatto se non avessi 
eseguito con `source`. 
In generale source si usa per impostare un 
ambiente di esecuzione. 
Attenzione, se nella prima riga dello script dici 
che lo vuoi eseguire con perl ma runni lo script 
in una shell bash con source da degli errori 
perche' bash non capisce i comandi di perl. 

Per creare una var locale fai `nomevariabile=val` 
per farla diventare d'ambiente fai `export nomevar`
Per vedere le variabili d'ambiente esiste il 
comando `env`. 
(se fai `env | more` ti fa vedere una pagina alla 
volta e fai enter per andare alla pagina succ. 
More non ti fa tornare indietro pero')

* Il comando `set` ti fa vedere TUTTE le variabili 
e anche le funzioni (si ci sono anche loro). 
`set` serve anche a fare altro: `set +o history`
disabilita la memorizzazione di ulteriori comandi 
in history (per riattivare `set -o history`).
`set -a` fa si che quando creo una variabile 
qualsiasi questa e' in automatico una var 
d'ambiente (adesso per creare una var locale usi 
di nuovo `export` che funziona al contrario 
pero')(`set +a` per togliere). 

Con il comando `unset var` posso eliminare le  
variabili.

Se fai `var=roba comando` il comando e' eseguito 
in un ambiente in cui esiste anche var. 

## CONFIGURAZIONE DELLA SHELL BASH

Ci sono diversi file per configurare la shell 
bash. Uno di questi e' `.bashrc` nella home dir 
dell'utente. 
In .bashrc si possono anche dichiarare variabili. 
Appena apri una nuova shell viene eseguito con il 
comando source il file `.bashrc` (cosi' poi  
rivedi le variabili dichiarate nello script) 

## HISTORY 

Con il comando `history` mi stampa tutti i cmandi 
che ho lanciato nella sessione. Infatti quando 
fai ctrl+P torni indietro tra i comandi che sono 
segnati coi numeri a fianco. Se devi rifare un 
comando vecchio puoi fare `!numeroscrittoinhistory`. 
Altrimenti `!inizialidiunvecchiocomando` ti 
esegue il primo comando che trova che inizia con 
quelle iniziali. 


