# 5 FILOSOFI

5 filosofi sono a cena, ogniuno ha bisogno di 2 bacchette ma ce ne sono solo 5 (non 10).
Quindi bisogna condividerle con un vincolo: ogni filosofo puo' solo prendere una bacchetta che gli sta di fianco.
Quando ha finito di usarla la puo' rimettere giu' solo di fianco a lui.

La vita di un filosofo;
```c (pseudo)
process Philo[i] { /* i = 0...4 */
    while (true) {
        think
        acquire chopsticks
        eat
        release chopsticks
    }
}
```


Una soluzione plausibile:
```c (pseudo)
Semaphore chopsticks = {new Semaphore(1), ..., new Semaphore(1) };
process Philo[i] { /* i = 0...4 */
    while (true) {
        think
        chopstick[i].P();
        chopstick[(i+1)%5].P();
        eat
        chopstick[i].V();
        chopstick[(i+1)%5].V();
    }
}
```


Perché è errata?
* Perché tutti i filosofi possono prendere la bacchetta di sinistra
(indice i) e attendere per sempre che il filosofo accanto rilasci
la bacchetta che è alla destra (indice (i+1)%5);
* Nonostante i filosofi muoiano di fame, questo è un caso di deadlock.

Quindi se partono tutti allo stesso momento e ogniuno prendono la propria bacchetta di sinistra sono fregati

Bisogna `rompere la simmetria` ...

Corretta: 
```c (pseudo)

process Philo[0] {   // solo il filosofo 0 fa cosi'
    while (true) {
        think
        chopstick[1].P();
        chopstick[0].P();
        eat
        chopstick[1].V();
        chopstick[0].V();
    }
}

process Philo[i] { /* i = 1...4 */
    while (true) {
        think
        chopstick[i].P();
        chopstick[(i+1)%5].P();
        eat
        chopstick[i].V();
        chopstick[(i+1)%5].V();
    }
}
```

Riparleremo di questi algoritmi per le gestione delle risorse (piu' processi voglio usare le stesse risorse condivise).

## Esercizi


