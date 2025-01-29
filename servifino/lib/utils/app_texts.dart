import 'package:servifino/pages/worker/profile_worker.dart';

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
  //Profile
static EditProfileWorker profile = EditProfileWorker();
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
  final String textInfo2 ='Questi dati verranno visualizzati dagli altri utenti.';
  final String succRegMessagge = 'Registrazione avvenuta con successo!';
  final String errRegMessagge = 'Errore durante la registrazione';
}

class LandingScreenTexts {
  final String logoutButton = 'Esci';
  final String landingTitle = 'Home';
  final String welcomeMessage = 'Benvenuto nella tua Home!';
}

class EditProfileWorker {
  final String editProfileAppBarTitle = 'Modifica profilo';
  final String successMessage = 'Modifica avvenuta con successo!';
  final String  errorMessage = 'Errore nella modifica.';
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
  final String confPasswordError = 'Le password devono essere valide e coincidere';
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
  final String cancel = 'Annulla';
  final String confirm = 'Conferma';
  final String save = 'Salva';
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


