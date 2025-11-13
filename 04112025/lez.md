# LAB del 04/11/2025

```bash
NUM=hjkl
echo ${NUM}
#stampa hjkl
echo ${#NUM}
#stampa 4 (lunghezza di NUM)
```

## GREP
Puo' essre lanciato con diversi parametri ma usiamo la sua funzione principale

```bash
grep gatto
# ora e' aperto stdin e grep sta ascoltando
# scrivi qua sotto parole tipo rigattoiere
```

```bash
grep gatto file.txt
# non legge da stdin ma da file.txt
```

```bash
cat file.txt | grep gatto
# stessa cosa di prima ma grep crede di leggere da stdin grazie al piping
```

* con l'opzione `-v` grep fa vedere le righe che NON contengono la parola (e' invertito)
* `-i` diventa case insensitive

```bash
grep ciao *.sh
#legge tutti i file che hanno estensione .sh
```

* `-h` non ti fa vedere il nome del file dove c'era la parola cercata
* `-H` te la fa vedere invece (e' il default)

* `-r` recursive (guarda anche dentro le cartelle)

## FIND

```bash
find .
# ti fa vedere tutti i percorsi di tutti i file dalla directory corrente
```

```bash
find /
# oddio no
```

* `-type d` ti fa vedere solo le directory
* `-type f` ti fa vedere solo i file

find fa vedere sempre anche i file o le dir nascosti

```bash
find . -maxdepth 2
# vado a cercare file al massimo a 2 livelli di profondita' (sotto dir)
```

```bash
find . -maxdepth 2 -mindepth 2
# ti fa vedere SOLO il 2ndo livello
```

```bash
find . -name ciao
# solo cose che hanno nome ciao
```

```bash
find . -name 'cia*'
# ci metto gli apici perche' non voglio che l'espansione la faccia la shell corrente (se dovesse riuscire) ma che venga interpretato da find
```

* per disattivare il case sensitive `-iname` invece che `-name`

```bash
find . -name 'cia*' -exec echo ciao '{}' \;
# metti \; perche' devi passarlo a find il ; non alla shell corrente che dopo pensa sia un separatore di comandi
# dentro '{}' ci mette l'output di find
```

`-exec ` fa eseguire il comando dopo per ogni cosa trovata

```bash
find . -type f -exec grep -i -h ciao '{}' \;
eseguo grep per ogni file
```


## RIDIREZIONAMENTI

quando la shell lancia una shell figlia questultima eredita anche una copia del file descriptor del padre, cosi' puo' usare i file aperti del padre... Ma si puo modificare!! 
-> Ridizionamenti

Da 281020205

Ridizionamenti:
* `<`   ricevere input da file
            comando < file
            in realta' equivale a `0<` 0 e' il file descriptor

* `>`   mandare output a file (eliminando quello che c'era prima)
            program > file
            nel processo figlio (quello di program) il file descriptor della tabella dei file del processo 
            figlio che prima corrispondeva allo stdout (`1>`) adesso corrisponde a file

* `>>`  mandare output a file (appendendo)
            program >> file

* ``       ricevere input da file

si possono fare anche contemporaneamente
```bash 
program < nome_file_input > nome_file_output
# oppure
program > nome_file_output < nome_file_input
```


Quando un programma ad esempio fallisce e ti stampa un errore in realta' quello viene stampato a schermo dallo `stderr` (standard error)

```bash 
ls -l NONESISTE esiste.txt 1> okout.txt 2> errout.txt
```


Se voglio dirigere sia stdin che stderr in uno stesso file si usa `&>`

### PIPE

anche `|` fa ridirezionamento

```bash 
program1 | program2
```

l'stdout di program1 diventa l'stdin di program2.

E' possibile pipare piu' processi:
```bash 
program1 | program2 | program3 | ...
```


# adesso fai esercizi lezione 4
Stesso livello di difficolta' all'esame


