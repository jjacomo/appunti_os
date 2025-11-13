// #include <pthread.h>
// #include <semaphore.h>
// #include <stdio.h>
// #include <stdlib.h>
// #include <time.h>
// #include <unistd.h>

/*
   Scrivi un programma che stampa in maniera indefinita
   la seguente stringa: "Quanto mi piace la piada!"

   Problema: devi farlo sincronizzando adeguatamente i
   seguenti processi:

   Process P1 {
       while (true) {
           printf("Quanto");
       }
   }

   Process P2 {
       while (true) {
           printf(" mi piace ");
       }
   }

   Process P2 {
       while (true) {
           printf("la piada!");
       }
  }


  SOLUZ:

  Semaphore sem1 = new Semaphore(1);
  Semaphore sem2 = new Semaphore(0);
  Semaphore sem3 = new Semaphore(0);

   Process P1 {
       while (true) {
           sem1.P();
           printf("Quanto");
           sem2.V();
       }
   }

   Process P2 {
       while (true) {
           sem2.P();
           printf(" mi piace ");
           sem3.V();
       }
   }

   Process P2 {
       while (true) {
           sem3.P();
           printf("la piada!");
           sem1.V();
       }
  }
*/
