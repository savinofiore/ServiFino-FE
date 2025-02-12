import 'dart:core';

class AppTexts {
  static const title = 'ServiFino';
  // Login Screen
  static LoginScreenTexts login = LoginScreenTexts();
  // Register Screen
  static RegisterScreenTexts register = RegisterScreenTexts();
  // Landing Screen
  static LandingScreenTexts landing = LandingScreenTexts();
  // Controllers
  static ControllersText controllers = ControllersText();
  // Utils
  static UtilsString utils = UtilsString();
  // BottomBar
  static BottomBarTexts bottomBarTexts = BottomBarTexts();
  //Profile Worker
  static EditProfileWorker profileWorker = EditProfileWorker();
  //Profile Owner
  static EditProfileOwner profileOwner = EditProfileOwner();
  //User ListTile
  static UserListTileTexts usrListTile = UserListTileTexts();
  // Reservation List Item
  static ReservationListItemTexts resListItem = ReservationListItemTexts();
  //History Owner
  static HistoryOwnerTexts historyOwner = HistoryOwnerTexts();

}

class LoginScreenTexts {
  final String loginButton = 'Accedi';
  final String loginAppBarTitle = 'Accedi';
  final String forgotPassword = 'Password dimenticata?';
  final String createAccount = 'Non hai ancora un account? Registrati';
}

class RegisterScreenTexts {
  final String registerAppBarTitle = 'Registrati';
  final String registerButton = 'Registrati';
  final String alreadyHaveAccount = 'Hai già un account? Accedi';
  final String passErrMessage = 'Le password non corrispondono';
  final String textInfo1 = 'Credenziali di accesso al profilo.';
  final String textInfo2 =
      'Questi dati verranno visualizzati dagli altri utenti.';
  final String textInfo3 = 'Utilizza l\'app per registrare la tua attività.';
  final String textInfo4 = 'Registra attività';
  final String succRegMessagge = 'Registrazione avvenuta con successo!';
  final String errRegMessagge = 'Errore durante la registrazione';
}

class LandingScreenTexts {
  final String logoutButton = 'Esci';
  final String landingTitle = 'Home';
  final String welcomeMessage = 'Benvenuto nella tua Home!';
  final String assignTitle = 'Configura profilo';
  final String activityName = 'Nome Locale';
  final String selectWork = 'Seleziona lavoro';
  final String activityDescription = 'Descrizione attività';
  final String availabilty = 'Disponibile per lavorare';
  final String activityLocation = 'Località attività';
  final String activityWebSite = 'Sito web attività';
  final String activityNumber = 'Contatto telefonico attività';
  final String activityNameDefault = 'Configura attività';
}

class EditProfileWorker {
  final String editProfileAppBarTitle = 'Modifica profilo';
  final String successMessage = 'Modifica avvenuta con successo!';
  final String errorMessage = 'Errore nella modifica.';
}

class EditProfileOwner {
  final String editProfileAppBarTitle = 'Modifica profilo';
  final String successMessage = 'Modifica avvenuta con successo!';
  final String errorMessage = 'Errore nella modifica.';
  final String defaultActivityName = 'Configura attività';
  final String editActivity = 'Modifica attività';
  final String editProfileOwner = 'Modifica Profilo Proprietario';
  final String actName = 'Nome Attività';
  final String actNameMsg = 'Il nome dell\'attività è obbligatorio';
  final String actDesc = 'Descrizione Attività';
  final String actAddress = 'Indirizzo Attività';
  final String actAddressError = 'L\'indirizzo dell\'attività è obbligatorio';
  final String actWebSite = 'Sito Web';
  final String actNumber = 'Numero di Telefono';
  final String actEditErrMessage = 'Errore durante il salvataggio del profilo.';
  final String actEditSuccMessage = 'Profilo salvato con successo!';
}

class ControllersText {
  final String email = 'Email';
  final String emailHint = 'Inserisci la tua mail';
  final String emailError = 'Inserisci un\'email valida';
  final String workHint = 'Inserisci la tua occupazione';
  final String work = 'Occupazione';
  final String password = 'Password';
  final String passwordHint = 'Inserisci la tua password';
  final String passwordError = 'La password deve avere almeno 6 caratteri';
  final String confPassword = 'Conferma Password';
  final String confPasswordHint = 'Conferma la tua password';
  final String confPasswordError =
      'Le password devono essere valide e coincidere';
  final String displayName = 'Nome utente';
  final String displayNameHint = 'Inserisci il tuo nome';
  final String displayNameError = 'Inserisci un nome utente';
  final String number = 'Numero di telefono';
  final String numberHint = 'Inserisci il tuo numero di telefono';
  final String numberError = 'Numero telefonico non valido (aggiungi prefisso)';
  final String editProfileBtn = 'Modifica Profilo';
  final String settingBtn = 'Impostazioni';
  final String logoutBtn = 'Disconnetti';
  final String logoutBtnTxt1 = 'Conferma logout';
  final String logoutBtnTxt2 = 'Sei sicuro di voler effettuare il logout?';
  final String editBtnTxt1 = 'Conferma modifiche';
  final String editBtnTxt2 = 'Sei sicuro di voler confermare le tue modifiche?';
  final String errorEditTxt1 = 'Errore durante il salvataggio delle modifiche';
  final String cancel = 'Annulla';
  final String confirm = 'Conferma';
  final String save = 'Salva';
  final String successOperationMessage = 'Operazione effettuata con successo';
  final String errorOperationMessage = 'Errore';
}

class UtilsString {
  final String photoExampleUrl = 'https://example.com/photo.jpg';
  final String available = 'Disponibile';
  final String notAvailable = 'Non disponibile';
}

class BottomBarTexts {
  final String firstIconText = 'Storico';
  final String secondIconText = 'Home';
  final String thirdIconText = 'Profilo';
}

class UserListTileTexts {
  final String defaultWork = 'non specificato';
  final String available = 'Disponibile';
  final String unavailable = 'Non disponibile';
  final String showDialogTitle = 'Prenota prestazione';
  final String showDialogMessage = 'Vuoi confermare la prenotazione?';
  final String successMessage = 'Prenotazione inserita';
  final String errorMessage = 'Prenotazione non inserita';
  final String btnText = 'Prenota';
}

class ReservationListItemTexts {
  final String done = 'Accetta';
  final String reject = 'Rifiuta';
  final String info = 'Info';
}

class HistoryOwnerTexts {
  final String emptyList = 'Nessuna prenotazione inviata';
  final String waitingStatus = 'In attesa';
  final String acceptedStatus = 'Accettata';
  final String rejectedStatus = 'Rifiutata';
}
