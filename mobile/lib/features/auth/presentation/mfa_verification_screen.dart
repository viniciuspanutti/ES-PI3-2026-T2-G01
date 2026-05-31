// Vinícius Panutti Salgado - 25007329
// ── mfa_verification_screen.dart ───────────────────────────────────────
// Tela de verificação de código MFA (Multi-Factor Authentication).
//
// Fluxo:
//   1. O login_screen.dart gera um código OTP de 6 dígitos
//   2. Envia o código por e-mail via EmailService.sendOTP()
//   3. Navega para esta tela passando o código como argumento
//   4. O utilizador digita o código recebido no e-mail
//   5. Se correto → navega ao dashboard (/main)
//      Se incorreto → exibe SnackBar de erro vermelho
//
// Segurança:
//   O expectedCode é passado em memória (não persistido em disco).
//   A validação é client-side por simplicidade no MVP.
//   Em produção, a validação deveria ocorrer no backend.
// ──────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:mobile/core/routes/app_routes.dart';

// ── MfaVerificationScreen — Widget Stateful ──────────────────────────
// Recebe o código esperado via construtor e compara com a entrada do user.
class MfaVerificationScreen extends StatefulWidget {
  // Código OTP de 6 dígitos gerado no login e enviado por e-mail
  final String expectedCode;

  const MfaVerificationScreen({super.key, required this.expectedCode});

  @override
  State<MfaVerificationScreen> createState() => _MfaVerificationScreenState();
}

class _MfaVerificationScreenState extends State<MfaVerificationScreen> {
  // Controller para capturar o texto digitado no campo de código
  final _codeController = TextEditingController();

  // ── _validateCode — Valida o código inserido pelo utilizador ───────
  // Compara o código digitado (trimmed) com o expectedCode.
  // Se match → navega ao dashboard limpando toda a pilha
  // Se mismatch → mostra SnackBar de erro
  void _validateCode() {
    final code = _codeController.text.trim();
    if (code == widget.expectedCode) {
      // Código correto: remove toda a pilha de navegação e vai ao dashboard
      // (route) => false garante que não há como "voltar" para o login
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.mainRoute, (route) => false);
    } else {
      // Código incorreto: exibe feedback visual ao utilizador
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Código incorreto! Tente novamente.'),
          backgroundColor: Colors.red.shade700,
        ),
      );
    }
  }

  @override
  void dispose() {
    // Libera o TextEditingController para evitar memory leaks
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificação MFA'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Ícone de segurança centralizado — feedback visual de que
            // o utilizador está numa tela de verificação de identidade
            const Icon(Icons.security, size: 80, color: Color(0xFF5A2D91)),
            const SizedBox(height: 24),
            // Instrução textual sobre o que o utilizador deve fazer
            const Text(
              'Insira o código de 6 dígitos que foi enviado para o seu e-mail.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            // Campo de texto configurado para entrada de código numérico:
            //   • maxLength: 6 → limita a 6 caracteres
            //   • letterSpacing: 8 → espaçamento visual entre dígitos
            //   • keyboardType: number → abre teclado numérico no mobile
            //   • counterText: '' → esconde o contador "0/6" default
            TextField(
              controller: _codeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, letterSpacing: 8),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '000000',
                counterText: '',
              ),
            ),
            const SizedBox(height: 32),
            // Botão de validação — cor roxa da marca (#5A2D91)
            ElevatedButton(
              onPressed: _validateCode,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5A2D91),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Validar Código', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

