05/11/2025

# ESERCIZIO

3 processi: 1 scommette su testa, l'altro su croce, il terzo lancia la moneta e assegna il punteggio al vincitore e toglie il punteggio al perdente; tutto cio' iterativamente (piu' volte lo fanno)

```c
// var condivise
int fineScommesse;
int puntata_p_testa, puntata_p_croce;   // quanto puntano
int punteggio_p_testa=0, punteggio_p_croce=0;   // punteggio
char vincitore; // t per testa e c per croce

// semafori
semaphore mutex = new semaphore(1); // mutua esclusione (?)
semaphore puntato = new semaphore(0);
semaphore lancio_effettuato = new semaphore(0);



Process P_testa{
    int terminato = 0;
    while(!terminato){
        //decide quanto puntare
        mutex.P();
        puntata_p_testa = rand();
        mutex.V();

        // avviso che ho puntato
        puntata.V();

        // aspetta che l'oracolo abbia pubblicato il risultato
        lancio_effettuato.P();

        // esulta o si lamenta
        mutex.P();
        if(vincitore == 't'){
            printf("YEE e' uscita testa");
        } else {
            printf("CHE PALLE");
        }
        terminato = fineScommesse;
        mutex.V();
    }
}

Process P_croce{
    while(!terminato){
        //decide quanto puntare
        mutex.P();
        puntata_p_testa = rand();
        mutex.V();

        // avviso che ho puntato
        puntata.V();

        // aspetta che l'oracolo abbia pubblicato il risultato
        lancio_effettuato.P();

        // esulta o si lamenta
        mutex.P();
        if(vincitore == 'c'){
            printf("YEE e' uscita croce");
        } else {
            printf("CHE PALLE");
        }
        terminato = fineScommesse;
        mutex.V();
    }
}

Process P_oracolo{
    while(not fineScommesse){
        // decide il numero di iterazioni
        int num_iterazioni = rand();

        for i = 1 to num_iterazioni{
            //aspetta che i processi puntino
            puntata.P(); //quando supero la prima un processo ha puntato
            puntata.P(); // adesso ha puntato anche il secondo

            //lancia la moneta e assegna i punteggi
            mutex.P();
            if(rand() < MAX_RAND/2){
                vincitore = 't'
                punteggio_p_testa++;
                punteggio_p_croce--
            } else {
                vincitore = 'c'
                punteggio_p_testa--
                punteggio_p_croce++;
            }
            mutex.V();

            //pubblica il risultato (avvisando gli altri)
            lancio_effettuato.V();
            lancio_effettuato.V();
        }
    }
    mutex.P();
    fineScommesse = 1;
    mutex.V();
}

```


Poi lui sta anche scrivendo il codice ma non c'e' bisogno



