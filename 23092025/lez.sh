# creare variabili (senza spazi, mi raccomando altrimenti pensa che e' un comando)
NUM=MERDA

# quando lancio un programma dentro la bash
# il programma che lancio eredita' una copia
# dell'ambiente di esecuzione (una copia parziale)
# della bash su cui l'ho runnato (variabili) e
# poi sta in una da un altra parte
# cosi' se il programma modifica le variabiili ne
# modifica la copia, nela tua bash rimangono uguali
#
# ora se fai ps vedi due bash in esecuzione
#

pwd

#per usare la variabile devi metterci davanti $
echo $NUM

# alcune variabili importanti
# PATH (modificabile dagli utenti) creata da os
# e' una var che concatena uno dopo l'altro diversi percorsi.
#
# Ad esempio quando lancio il comando gcc lui cerca delle
# directory per trovarlo. Altrimenti
# puoi eseguire file specidicando il percorso.
# Ecco le directory in cui cerca
# sono quelle specificate in PATH.
# Per trovare in che directory sta il programma esiste il
# comando which; scrivi `which gcc`.

which gcc

# Questo serve perche' altrimenti la mia shell poverina
# impazzirebbe ogni volta a cercare in tutto il file system
# e ci metterebbe 2h ogni volta
#
# Se il file eseguibile e' in due directory diverse viene
# eseguito il primo che trova obv.
#
# Se l' eseguibile non e' nella path lo posso runnare
# lo stesso se specifico tutto il perscorso per dove trovarlo

# ps e' il comando per dirmi i processi in esecuzione adesso
# bash e' il comando per aprire una shell figlia dentro quella
# in cui sei. E' una copia completa. Infatti ora se rilancio ps
# c'e' un altra shell.
# Il PID e' il process identifier.
# PPID e' il pid del padre (tipo quando runni un programma che
# viene creata un altra shell figlia)
# usa exit per uscire dalla shell.

bash
PATH=
gcc
exit
gcc

# crei una nuova shell figlia e modifica PATH vedi che non
# funziona piu' (attenro a non farlo)
#

# quando apri una nuova shell ti mette dentro la directory
# dell'utente.

# Due tipi di istruzioni che puoi dare a una shell
# comandi (built in): non cerca nella PATH il programma,
# ce l'ha nel suo codice
#
# file binari eseguibili: li cerca nella PATH
#
# ci sono anche gli script (che sto scrivendo in questo file)
#

# allora il carattere # segna l'inizio di un commento
# ma se all'inizio degli script (solo all'inizio funziona)
# scrivi #!/bin/bash specifichi che vuoi che questo file sia
# interpretato da bash. Quindi potrei anche fare #!/usr/bin/perl
# dipende da cosa voglio fare. Alcuni capiscono delle cose che
# altri non capiscono.
#
# Se non specifichi con chi vuoi runnare viene usato lo stesso
# in cui dei adesso (creando una shell uguale figlia come
# ho detto prima)

# "nano di merda" cit Ghini
#

# comunque non e' detto che i comandi siano tutti eseguibili
# e poi puo' darsi che tu non abbia il permesso di eseguire
# (o leggere o modificare) e quindi il sistema operativo non
# te lo permette
#
# UTENTI, GRUPPI;
#
# un utente e' identificato da una stringa (nome utente) e,
# in egual modo un userid; Quando si crea un utente gli e'
# assegnato contemporaneamente anche un gruppo con il suo
# groupid. Ogni utente appartiene almeno (anche di piu di 1)
# ad un gruppo. Quando un utente crea un file e' di proprieta'
# sua e del suo gruppo. A ciascun file e' associato un
# proprietario e un gruppo quindi. Prop e grup possono essere
# cambiati successivamente. Il proprietario puo' definire i
# permessi per quel file;
#
# PERMESSI
# USER       GROUP        OTHERS
# r w x      r w x        r w x        (read write execute)
#
# btw il primo carattere quando fai ls e' il tipo del file
# (d sta per directory, c vuol dire che e' un device file
# pensa al mmio (mem mapped io), b rappresenta un disco (sda1
# e' una partizione dentro sda (disco)), l vuol dire che un
# symlink)
#
# il permesso di r vale 4, w vale 2, x vale 1; Quindi se un file ha
# rwx r-- ---
# 7   4   0
#
# per cambiare i permessi fai chmod n1n2n3
# chmod 740
#
# WOW cosi' ho cambiato i permessi per primo.sh e ora posso
# eseguirlo anche con ./

# btw in linux le estensioni dei file non significano nulla
# (sono piu' leggibili per noi)
#

# nel frattempo ha usato anche i comandi cat e touch

# in una directory se ho i permessi di lettura vuol dire che
# posso leggere i file che ci sono dentro, se posso modificare
# posso rinominare file, crearne etc...
# Il permesso di esecuzione mi permette di spostarmi logicamente
# in quella directory
#

# i permessi dei file non vengono salvati proprio sui file ma nella
# struttura dati in cui sono salvati i file nel file system
