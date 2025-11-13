# Message Passing
Slide 64 porg-concorrente-2

Mandare e ricevere messaggi tra processi (mittente e destinatario)

Operazioni `send` e `receive`
* send: utilizzata dal processo mittente per mandare
* receive: per ricevere


Non e' possibile fare sniffing dei messaggi tra due processi.

## Asincrono
* Send asincrono
    1. sintassi: `asend(m, q);`
    2. il mittente p spedisce il messaggio m al processo q, senza bloccarsi in attesa che il destinatario esegua l'operazione areceive(m, p)

* Receive bloccante: (finche )
intassi: m = areceive(p)
    1. il destinatario q riceve il messaggio m dal processo p; se il mittente non ha ancora spedito alcun messaggio, il destinatario si blocca in attesa di ricevere un messaggio
    2. è possibile lasciare il mittente non specificato (utilizzando *)


Noi studieremo l'asincrona.


Nell'attesa tra quando hai sendato e quando aspetti il receive dove sta il messaggio`?`
Se parliamo di un server (whatsapp ad esempio) sta sul cloud da qualche parte.
Se siamo nel message passing del sistema operativo il messaggio sara' memorizzato da qualche parte nel os



### Esempio producer consumer

Il PCmanager (prod cons manager) serve nel caso ci siano piu' produttori/consumatori:
<!-- Dio cane come cazzo spiega -->

### Esempio filosofi a cena

Non ho ascoltato nucazz





















