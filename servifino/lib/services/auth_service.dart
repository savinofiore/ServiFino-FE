import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
class AuthService {

  Future<Map<String, dynamic>?> registerUser({
    required String email,
    required String password,
    required String displayName,
    required String phoneNumber,
    required String photoURL,
  }) async {

    String url = dotenv.env['CREATE_USER_ENDPOINT'] ?? '';

    try {
      final body = json.encode({
        'email': email,
        'password': password,
        'displayName': displayName,
        'phoneNumber': phoneNumber,
        'photoURL': photoURL,
        'disabled': false,
        'assignment': false,
      });

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Registrazione avvenuta con successo! ${response.body}');

        // Parse JSON dell'utente dalla risposta
        final Map<String, dynamic> responseData = json.decode(response.body);

        // Ritorna i dati dell'utente
        return responseData['user']; // Assumi che il backend restituisca il JSON utente sotto la chiave "user"
      } else {
        print('Errore nella registrazione: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Errore durante la chiamata all\'API: $e');
      return null;
    }
  }

}
