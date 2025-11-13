#include <pthread.h>
#include <semaphore.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

#define NUM_PHILOSOPHERS 5
#define MAX_MEALS 10 // Numero massimo di pasti per filosofo

// Array di semafori per le bacchette
sem_t chopsticks[NUM_PHILOSOPHERS];
// pthread_mutex_t stats_mutex = PTHREAD_MUTEX_INITIALIZER;
sem_t stats_mutex;

// Contatori per statistiche
int meals_eaten[NUM_PHILOSOPHERS] = {0};

// Nomi dei filosofi per output più leggibile
const char *philosopher_names[] = {"Aristotele", "Platone", "Socrate", "Kant",
                                   "Nietzsche"};

// Funzione per simulare il pensiero
void think(int philosopher_id) {
    printf("%s (Filosofo %d) sta pensando...\n",
           philosopher_names[philosopher_id], philosopher_id);

    // Simula tempo di riflessione (tra 1 e 3 secondi)
    usleep((rand() % 2000 + 1000) * 1000);
}

// Funzione per simulare il mangiare
void eat(int philosopher_id) {
    sem_wait(&stats_mutex);
    meals_eaten[philosopher_id]++;
    int meal_count = meals_eaten[philosopher_id];
    sem_post(&stats_mutex);

    printf(">>> %s (Filosofo %d) sta mangiando (pasto #%d)...\n",
           philosopher_names[philosopher_id], philosopher_id, meal_count);

    // Simula tempo di consumo del pasto (tra 1 e 2 secondi)
    usleep((rand() % 1000 + 1000) * 1000);
}

// Funzione per prendere le bacchette
void pick_up_chopsticks(int philosopher_id, int left_chopstick,
                        int right_chopstick) {
    printf("%s (Filosofo %d) vuole prendere le bacchette %d e %d\n",
           philosopher_names[philosopher_id], philosopher_id, left_chopstick,
           right_chopstick);

    // Prende la prima bacchetta
    sem_wait(&chopsticks[left_chopstick]);
    printf("|| %s (Filosofo %d) ha preso la bacchetta %d\n",
           philosopher_names[philosopher_id], philosopher_id, left_chopstick);

    // Prende la seconda bacchetta
    sem_wait(&chopsticks[right_chopstick]);
    printf("|| %s (Filosofo %d) ha preso la bacchetta %d\n",
           philosopher_names[philosopher_id], philosopher_id, right_chopstick);
}

// Funzione per rimettere le bacchette
void put_down_chopsticks(int philosopher_id, int left_chopstick,
                         int right_chopstick) {
    // Rimette le bacchette
    sem_post(&chopsticks[left_chopstick]);
    sem_post(&chopsticks[right_chopstick]);

    printf("--- %s (Filosofo %d) ha rimesso le bacchette %d e %d\n",
           philosopher_names[philosopher_id], philosopher_id, left_chopstick,
           right_chopstick);
}

// Funzione del filosofo 0 (ordine speciale per evitare deadlock)
void *philosopher_0(void *arg) {
    int philosopher_id = 0;

    while (1) {
        // Controlla se ha raggiunto il limite di pasti
        sem_wait(&stats_mutex);
        if (meals_eaten[philosopher_id] >= MAX_MEALS) {
            sem_post(&stats_mutex);
            break;
        }
        sem_post(&stats_mutex);

        // Pensa
        think(philosopher_id);

        // Prende le bacchette in ordine speciale: prima 1, poi 0
        pick_up_chopsticks(philosopher_id, 1, 0);

        // Mangia
        eat(philosopher_id);

        // Rimette le bacchette
        put_down_chopsticks(philosopher_id, 1, 0);
    }

    printf("[OK] %s (Filosofo %d) ha terminato dopo %d pasti\n",
           philosopher_names[philosopher_id], philosopher_id, MAX_MEALS);
    return NULL;
}

// Funzione per i filosofi da 1 a 4
void *philosopher_i(void *arg) {
    int philosopher_id = *((int *)arg);

    while (1) {
        // Controlla se ha raggiunto il limite di pasti
        sem_wait(&stats_mutex);
        if (meals_eaten[philosopher_id] >= MAX_MEALS) {
            sem_post(&stats_mutex);
            break;
        }
        sem_post(&stats_mutex);

        // Pensa
        think(philosopher_id);

        // Prende le bacchette: prima la propria, poi quella a destra
        int left_chopstick = philosopher_id;
        int right_chopstick = (philosopher_id + 1) % NUM_PHILOSOPHERS;

        pick_up_chopsticks(philosopher_id, left_chopstick, right_chopstick);

        // Mangia
        eat(philosopher_id);

        // Rimette le bacchette
        put_down_chopsticks(philosopher_id, left_chopstick, right_chopstick);
    }

    printf("[OK] %s (Filosofo %d) ha terminato dopo %d pasti\n",
           philosopher_names[philosopher_id], philosopher_id, MAX_MEALS);
    return NULL;
}

int main() {
    // Inizializza il generatore di numeri casuali
    srand(time(NULL));

    printf("=== PROBLEMA DEI FILOSOFI A CENA ===\n");
    printf("Numero di filosofi: %d\n", NUM_PHILOSOPHERS);
    printf("Pasti massimi per filosofo: %d\n\n", MAX_MEALS);

    // Inizializza il semaforo mutex per le statistiche
    if (sem_init(&stats_mutex, 0, 1) != 0) {
        perror("Errore inizializzazione semaforo stats_mutex");
        exit(1);
    }

    // Inizializza i semafori delle bacchette (tutti a 1)
    for (int i = 0; i < NUM_PHILOSOPHERS; i++) {
        if (sem_init(&chopsticks[i], 0, 1) != 0) {
            perror("Errore nell'inizializzazione dei semafori delle bacchette");
            exit(1);
        }
        printf("Bacchetta %d inizializzata\n", i);
    }

    printf("\nI filosofi si siedono al tavolo...\n\n");

    // Array di thread e ID
    pthread_t philosophers[NUM_PHILOSOPHERS];
    int philosopher_ids[NUM_PHILOSOPHERS];

    // Crea il thread per il filosofo 0 (caso speciale)
    if (pthread_create(&philosophers[0], NULL, philosopher_0, NULL) != 0) {
        perror("Errore nella creazione del thread filosofo 0");
        exit(1);
    }

    // Crea i thread per i filosofi da 1 a 4
    for (int i = 1; i < NUM_PHILOSOPHERS; i++) {
        philosopher_ids[i] = i;
        if (pthread_create(&philosophers[i], NULL, philosopher_i,
                           &philosopher_ids[i]) != 0) {
            perror("Errore nella creazione del thread filosofo");
            exit(1);
        }
    }

    // Attende la terminazione di tutti i filosofi
    for (int i = 0; i < NUM_PHILOSOPHERS; i++) {
        pthread_join(philosophers[i], NULL);
    }

    // Stampa statistiche finali
    printf("\n=== STATISTICHE FINALI ===\n");
    int total_meals = 0;
    for (int i = 0; i < NUM_PHILOSOPHERS; i++) {
        printf("%s (Filosofo %d): %d pasti\n", philosopher_names[i], i,
               meals_eaten[i]);
        total_meals += meals_eaten[i];
    }
    printf("Totale pasti consumati: %d\n", total_meals);

    // Distrugge i semafori
    for (int i = 0; i < NUM_PHILOSOPHERS; i++) {
        sem_destroy(&chopsticks[i]);
    }
    sem_destroy(&stats_mutex);

    printf("\nTutti i filosofi hanno terminato. Arrivederci!\n");
    return 0;
}
