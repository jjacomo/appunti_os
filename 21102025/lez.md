# NON SONO SICURO SE SIA QUESTO QUELLO CHE ABBIAMO FATTO A LEZIONE MA E' QUELLO CHE MI MANCA

## Parameter Expansion

- $#  il numero di argomenti passati allo script
- $0  il nome del processo in esecuzione
- $1  il primo argomento, $2 il secondo...
- $*  tutti gli argomenti concatenati separati da spazi
- $@  come $* ma se quotato gli argomenti vengono quotati separatamente


## Operatori (()) e $(()) (Arithmetic expansion)


- (())   valuta le espressioni aritmetiche al suo interno
    ```bash
    (( NUM=3+2))
    ```

    Assegna 5 alla variabile NUM

- $(())  e' come (()) ma puo' essere usato in una parte della riga di comando 
         e non tutta come richiede (())

## Exit Status

Slide 88

## FOR

```bash
for (( expr1 ; expr2 ; expr3 )) ; do list ; done

for varname in elencoword ; do list ; done

while list ; do list ; done
```

es. 

```bash
for (( i=0 ; $i<13; i=$i+2 )) ; do echo ciao$i ; done
```

## CONDIZIONALI
```bash

```

