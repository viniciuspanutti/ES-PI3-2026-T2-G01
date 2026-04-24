// feito por camila fernandes costacurta RA:25012949 
import 'storage.dart';

class AuthService {
  static Future<void> register({
    required String name,
    required String email,
    required String cpf,
    required String phone,
    required String password,
  }) async {
    final users = await AppStorage.getUsers();
    final exists = users.any((u) => (u['email']?.toString().toLowerCase() ?? '') == email);
    if (exists) {
      throw Exception('E-mail ja cadastrado');
    }

    users.add({
      'name': name,
      'email': email,
      'cpf': cpf,
      'phone': phone,
      'password': password,
      'mfaEnabled': false,
    });
    await AppStorage.saveUsers(users);
    await AppStorage.setCurrentEmail(null);
    await AppStorage.setMfaEnabled(false);
  }

  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    final users = await AppStorage.getUsers();
    Map<String, dynamic>? foundUser;
    for (final user in users) {
      final userEmail = user['email']?.toString().toLowerCase() ?? '';
      final userPassword = user['password']?.toString() ?? '';
      if (userEmail == email && userPassword == password) {
        foundUser = user;
        break;
      }
    }
    if (foundUser == null) {
      throw Exception('Credenciais invalidas');
    }

    await AppStorage.setCurrentEmail(email);
    await AppStorage.setMfaEnabled(foundUser['mfaEnabled'] == true);
    return foundUser['mfaEnabled'] == true;
  }

  static Future<void> sendPasswordReset(String email) async {
    final users = await AppStorage.getUsers();
    final exists = users.any((u) => (u['email']?.toString().toLowerCase() ?? '') == email);
    if (!exists) {
      throw Exception('E-mail nao encontrado');
    }
    // Fluxo local: simula envio de instrucoes com sucesso.
    await Future<void>.delayed(const Duration(milliseconds: 300));
  }
}
