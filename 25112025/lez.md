# INTRO

altre espansioni di variabili, scaricare roba con apt, 

---

### killall

P.197

Per ammazzare un po' di processi in una botta sola.

---

## Parameter expansion

P.208

```bash
echo ${#VAR} # stampa la dimensione della variabile (numero di caratteri)
```


suffisso: sta alla fine
prefisso: sta all'inizio


Esempio di uso: estrarre numero tra [] in `VAR="[13] qualcosa con [ o ] fine“`

pattern puo’ contenere wildcard che cercano di matchare con sottostringhe in VAR
pattern puo’ contenere anche variabili

### %: Rimuove suffisso piu' lungo

```bash
${VAR%%pattern}

# ad esempio

echo ${VAR%%]*}

# Rimuovo il piu’ lungo suffisso che fa match con stringa orig.
# Rimuovo fino alla fine a destra la sottostringa piu’ lunga che inizia con "]"

#  quindi stampa [13 

```

Poi (`suffisso piu' corto`)

```bash
${VAR%pattern}

echo ${VAR%]*}

## Rimuovo il piu’ corto suffisso che fa match con stringa orig

# [13] qualcosa con [ o Rimuovo fino alla fine della stringa originale
# la sottostringa piu’ corta che inizia con ]
```


### invece il #: (Rimuove il prefisso (piu' lungo))

```bash
${VAR##pattern}

echo ${VAR##*[}

# Rimuovo il piu’ lungo prefisso che fa match con stringa orig
# o ] fine Rimuovo, dall’inizio dell’originale, la sottostringa piu’ lunga
# che finisce con [
```

Poi (`Prefisso piu' corto`)

```bash
${VAR#pattern}

echo ${VAR#*[}

# Rimuovo il piu’ corto prefisso che fa match con stringa orig
# 13] qualcosa con [ o ] fine Rimuovo, dall’inizio dell’originale, la sottostringa piu’ corta
# che finisce con [ 
```


### assomiglia a sed

```bash
${VAR/pattern/string}
# sostituisce pattern con string
```

Esempio

```bash
VAR="alfabetagamma"
ALTRA="vaf"

echo "${VAR/b*a/k${ALTRA}p}" # sostituisce la stringa piu' lunga che matcha, se sono possibili piu' sostituzioni sostituisce la stringa piu' vicina all'inizio
# produce in output: alfakvafp
```


### offset (operatore :)

```bash
${VAR:offset}

# sottostringa che parte dal offset-esimo carattere del contenuto di VAR
# L’offset del primo carattere e’ zero. Gli argomenti vengono valutati
# aritmeticamente. Lo stesso per il prossimo operatore
```


o anche

```bash
${VAR:offset:length} # sottostringa lunga length che parte dal offset-esimo carattere del contenuto di VAR

# es: 
VAR="alfabetagamma"
DA="3"
FINOA="5"
echo "${VAR:${DA}:${FINOA}+3}"

# produce in output: fabetaga
```



#### Esempio grosso

```bash
# esempio: come effettuare piu’ sostituzioni nel contenuto di una variabile

#!/bin/bash
VAR="a1BDaxxx2BaDxxx3BbDxx4BcDxxx5BDxxx6BdD"
PREVIOUS=${VAR}

while true ; do
    VAR=${VAR/B?D/ZZZ}
    if [ ${VAR} == ${PREVIOUS} ] ; then
        break ;
    else
        PREVIOUS=${VAR}
    fi
done
echo "VAR=${VAR}"
# Lo script visualizza
# VAR=a1BDaxxx2ZZZxxx3ZZZxx4ZZZxxx5BDxxx6ZZZ
# --------------------------------------------------------
# NB: più semplicemente si poteva usare: VAR=${VAR//B?D/ZZZ} che vediamo dopo
```


### Operatore //

```bash
${VAR//pattern/string} #quando dopo il primo / c'e' un altro / allora TUTTE le
# sottostringhe che fanno match con il pattern specificato
# vengono sostituite, non solo la prima.
# esempio: sostituisce tutti i cane con gatto {VAR//cane/gatto}
# esempio: sostituisce tutti gli asterischi * con \* per impedire
# che il contenuto della variabile possa essere interpretato.
${VAR//\*/\\\*}
```


### Operatore #

```bash
${VAR/#pattern/string} # quando dopo il primo / c'e' un # allora il pattern viene
# sostituito SOLO SE si trova all' INIZIO della variabile.

```


### Opratore %
```bash

${VAR/%pattern/string} # quando dopo il primo / c'e' un % allora il pattern viene
# sostituito SOLO SE si trova
```


### !*

```bash
# Espansione verso nomi di variabili corrispondenti ad un prefisso pattern
# ${!VarNamePrefix*} restituisce un elenco con tutti i nomi delle variabili
# il cui nome inizia con il prefisso specificato VarNamePrefix

# Esempio: se esistono le seguenti variabili

BASH=/bin/bash
BASH_ALIASES=()
BASH_ARGC=()
BASH_ARGV=()
BASH_CMDS=()
BASH_LINENO=()
BASH_SOURCE=()
BASH_VERSION='4.1.17(9)-release'
CYG_SYS_BASHRC=1
# ed eseguo il comando
echo ${!BASH_AR*}
# vedro’ in output
# BASH_ARGC BASH_ARGV
```


## Ma perche'?

Perche' dovrei usare ste robe qua invece che usare direttamente `sed` a sto punto, tanto fa la stessa cosa...
Eh no, cosi' sono molto piu' efficienti perche' sono shell built in, non e' un programma esterno (non vengono lanciati eseguibili (richiede molto tempo)).



# apt


ha fatto
```bash
sudo apt-get update
```
per aggiornare la lista dei pacchetti

Poi:
```bash
sudo apt-get install aptitude
```

Poi 
```bash
aptitude search gcc | more
```

ti fa vedere tutti i pacchetti che "centrano" con gcc (hanno gcc nel nome (?)).

Poi
```bash
sudo apt-get install wget
# e
sudo apt-get install geany # che e' un editor di testo
```

Poi
```bash
wget https://www.cs.unibo.it/~ghini/didattica/sistemioperativi/Occhio3cm.jpg
```

Poi
```bash
wget https://www.cs.unibo.it/~ghini/index.html
```

Ma cosi' scarichi solo un html...

Allora (all'esame ci fa usare questo comando)

```bash
wget --recursive --level=2 --page-requisites --convert-links --no-parent https://www.cs.unibo.it/~ghini/index.html

# oppure

wget -r -l 2 -p -k -np URL


# --level=2 dice che al massimo scarica la roba che puoi raggiungere con 2 link di profondita'
```

---


# TORNIAMO SU GPG (comandi)

```bash
sha256sum nome_file # di solito e' gia' presente nelle coreutils (su arch c'e')
```

sha256sum da in output il digest poi un carattere che ti dice da che tipo di file e' stato fatto (il digest) per il file di testo e' uno spazio, e infine il nome del file.

in alternativa c'e' il pacchetto openssl per generare digest di file

per verificare un digest

```bash
sha256sum -c nome_file.sha256 # confronta il digest (nome_file.sha256) con quello ottenuto da nome_file facendolo al volo
# se sono uguali stampa:
# nome_file: OK
```


## package gnupg (e gpgv)

```bash
gpg --list-secret-keys
# se non hai mai fatto sto comando ti crea la dir .gnupg nella tua home dove mettera' tutte le chiavi che genererai. Altrimenti te le stampa (?)
```

```bash
gpg --gen-key # crea una coppia di chiavi pub e priv con le impostazioni di default (RSA)
# altrimenti se non vuoi default 
# gpg --full-gen-key
```

Questo comando ti chiede nome email password per creare le tue chiavi


(gli piace molto il film predator)


Quando genera le chiavi ti stampa anche l'identificatore della coppia di chiavi;
Serve quando nello stesso sistema hai chiavi diverse per firmare cose diverse.


<!-- diocane se non fa la pausa mi cago addosso -->

## Firmiamo
adesso che abbiamo le nostre chiavi possiamo firmare dei file (e pacchetti nostri volendo).

### FIrma detached

crea un file separato con la firma per quel file

```bash 
gpg --armor --detach-sign nomefile
# mette la firma in nomefile.asc
# se non metti il --armor crea nomefile.sig che ha la stessa firma ma in binario(?)
```


### Firma inline

La firma viene inserita insieme al file originale in un altro file

```bash
gpg --clearsign nomefile 
# crea nomefile.asc con file e firma sotto
```



### Firma inplace

crea file binario con firma e file insieme

```bash
gpg --sign nomefile
# crea nomefile.gpg
```


## Verificare la firma

ci e' arrivato ad esempio un file.gpg e vogliamo verificare se non ci vogliono fregare

```bash
gpg --verifiy nomefile.asc nomefile # per la detached
```

usa la chiave cha hai generato prima (?)
