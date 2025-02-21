# ServiFino

L'app per prenotare personale nel settore terziario.

## Sommario
- [Struttura dell’Applicazione](#struttura-dellapplicazione)
- [Gestione degli Utenti](#gestione-degli-utenti)
- [Funzionalità Principali](#funzionalità-principali)
- [Installazione e Avvio](#installazione-e-avvio)
- [Struttura del Progetto](#struttura-del-progetto)
- [Contributi](#contributi)
- [Licenza](#licenza)

---

## Struttura dell’Applicazione
![img_1.png](img_1.png)

Questo diagramma illustra il flusso logico dell’app, a partire dallo **Start** fino alle diverse schermate in base al ruolo dell’utente (Owner o Worker).

1. **Start**: il sistema verifica se l’utente è già loggato.
2. Se **non loggato**, viene mostrata la schermata di **autenticazione e registrazione**.
3. Se l’utente è loggato, il sistema controlla se si tratta di un **Owner** o di un **Worker**.
4. A seconda del ruolo, viene mostrata la **Landing Page** dedicata:
    - **Owner**: può accedere a funzionalità di gestione prenotazioni, gestione del profilo e altre funzioni di amministrazione.
    - **Worker**: può visualizzare e gestire le prenotazioni assegnate, modificare il proprio profilo, ecc.

Il diagramma evidenzia inoltre i punti di logout e le relative transizioni di stato.

---

## Gestione degli Utenti

La logica alla base del sistema è determinata da un campo booleano, `isOwner`, all’interno della collection `users`.

- Se `isOwner` è **true**, l’utente è identificato come **Owner** (gestore).
- Se `isOwner` è **false**, l’utente è identificato come **Worker** (lavoratore).

Questo approccio semplifica la gestione dei ruoli, assicurando che ciascun utente possa accedere solo alle funzionalità pensate per il proprio ruolo.

---

## Funzionalità Principali

- **Autenticazione e Registrazione**: possibilità di registrarsi come nuovo utente e autenticarsi.
- **Gestione Prenotazioni (Owner)**: visualizzare, creare, modificare e cancellare prenotazioni.
- **Gestione Prenotazioni (Worker)**: visualizzare e gestire le prenotazioni assegnate, accettare o rifiutare richieste.
- **Modifica Profilo**: ogni utente (Owner o Worker) può aggiornare i propri dati personali.
- **Logout**: terminare la sessione e tornare alla schermata di login.


---

## Struttura del Progetto

Ecco la struttura della cartella `lib/`, personalizzata in base al progetto:

```bash
lib/
├── interfaces/
│   ├── BaseLandingPage.dart
│   ├── BaseProfile.dart
│   ├── BaseProvider.dart
│   ├── IApp.dart
│   └── ModelInterface.dart
├── models/
│   ├── OwnerModel.dart
│   ├── ReservationModel.dart
│   ├── UserModel.dart
│   └── WorksModel.dart
├── pages/
├── modelsProviders/
├── screens/
│   ├── authentication/
│   ├── landing_assignment.dart
│   └── landing_assignment_provider.dart
├── services/
├── trash/
├── auth/
├── utils/
│   ├── app_endpoints.dart
│   ├── app_routes.dart
│   ├── app_texts.dart
│   ├── request_errors.dart
│   ├── reservation_end.dart
│   └── ...
├── widgets/
│   ├── add_reservation_field.dart
│   ├── auth_router_wrapper.dart
│   ├── firebase_options.dart
│   └── ...
└── main.dart
```

---