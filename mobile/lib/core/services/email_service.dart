// Vinícius Panutti Salgado - 25007329
// ── email_service.dart ─────────────────────────────────────────────────
// Camada Core/Services — Serviço responsável por disparar o envio de
// e-mails de verificação MFA (Multi-Factor Authentication) para o
// utilizador via Cloud Function do Firebase.
//
// Arquitetura:
//   O Flutter NÃO envia e-mails diretamente. Em vez disso, faz uma
//   chamada HTTP segura (httpsCallable) para a Cloud Function
//   'sendMfaEmail' hospedada no Firebase Functions, que utiliza
//   o Nodemailer com SMTP do Gmail para entregar o código OTP.
//
// Fluxo:
//   1. login_screen.dart gera um código OTP aleatório de 6 dígitos
//   2. Chama EmailService.sendOTP(email, code)
//   3. A Cloud Function recebe {email, code} e envia o e-mail
//   4. O utilizador recebe o código e insere na MfaVerificationScreen
// ──────────────────────────────────────────────────────────────────────

// SDK de Cloud Functions do Firebase para chamadas httpsCallable
import 'package:cloud_functions/cloud_functions.dart';

// ── EmailService — Classe utilitária estática para envio de e-mails ──
// Utiliza o padrão de métodos estáticos pois não mantém estado interno.
// Toda a lógica de transporte (SMTP, credenciais) fica no backend.
class EmailService {
  /// Envia um código OTP de verificação MFA para o e-mail fornecido.
  ///
  /// Parâmetros:
  ///   [userEmail] — endereço de e-mail do utilizador autenticado
  ///   [otpCode] — código numérico de 6 dígitos gerado aleatoriamente
  ///
  /// Lança [Exception] caso a Cloud Function falhe (rede, timeout, etc.)
  static Future<void> sendOTP(String userEmail, String otpCode) async {
    try {
      // Obtém referência à Cloud Function 'sendMfaEmail' registrada
      // no ficheiro functions/src/index.ts. O httpsCallable garante
      // que a chamada é autenticada com o token Firebase do utilizador.
      final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('sendMfaEmail');
      // Envia o payload com e-mail e código. A Cloud Function
      // configura o Nodemailer e despacha o e-mail via SMTP Gmail.
      await callable.call(<String, dynamic>{
        'email': userEmail,
        'code': otpCode,
      });
    } catch (e) {
      // Re-lança como Exception genérica para que a UI possa
      // capturar e exibir uma mensagem amigável ao utilizador.
      throw Exception('Falha ao enviar e-mail: $e');
    }
  }
}

