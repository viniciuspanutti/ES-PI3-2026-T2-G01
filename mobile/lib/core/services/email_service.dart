import 'package:cloud_functions/cloud_functions.dart';

class EmailService {
  static Future<void> sendOTP(String userEmail, String otpCode) async {
    try {
      final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('sendMfaEmail');
      await callable.call(<String, dynamic>{
        'email': userEmail,
        'code': otpCode,
      });
    } catch (e) {
      throw Exception('Falha ao enviar e-mail: $e');
    }
  }
}
