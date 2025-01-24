class AppTexts {
  static const title = 'ServiFino';
  // Login Screen
  static LoginScreenTexts login = LoginScreenTexts();
  // Register Screen
  static RegisterScreenTexts register = RegisterScreenTexts();
  // Home Screen
  static HomeScreenTexts home = HomeScreenTexts();
  // Controllers
  static ControllersText controllers = ControllersText();
}

class LoginScreenTexts {
  final String loginButton = 'Accedi';
  final String loginAppBarTitle= 'Accedi';
  final String forgotPassword = 'Password dimenticata?';
  final String createAccount = 'Non hai ancora un account? Registrati';
}

class RegisterScreenTexts {
  final String registerAppBarTitle = 'Registrati';
  final String registerButton = 'Registrati';
  final String alreadyHaveAccount = 'Hai già un account? Accedi';
  final String textInfo1 = 'Credenziali di accesso al profilo.';
  final String textInfo2 = 'Questi dati verranno visualizzati dagli altri utenti.';
}

class HomeScreenTexts {
  final String logoutButton = 'Esci';
  final String welcomeMessage = 'Benvenuto nella tua Home!';
}

class ControllersText {
  final String email = 'Email';
  final String emailHint = 'Inserisci la tua mail';
  final String emailError = 'Inserisci un\'email valida';
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
}

