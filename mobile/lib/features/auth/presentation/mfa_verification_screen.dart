import 'package:flutter/material.dart';
import 'package:mobile/core/routes/app_routes.dart';

class MfaVerificationScreen extends StatefulWidget {
  final String expectedCode;

  const MfaVerificationScreen({super.key, required this.expectedCode});

  @override
  State<MfaVerificationScreen> createState() => _MfaVerificationScreenState();
}

class _MfaVerificationScreenState extends State<MfaVerificationScreen> {
  final _codeController = TextEditingController();

  void _validateCode() {
    final code = _codeController.text.trim();
    if (code == widget.expectedCode) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.mainRoute, (route) => false);
    } else {
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
            const Icon(Icons.security, size: 80, color: Color(0xFF5A2D91)),
            const SizedBox(height: 24),
            const Text(
              'Insira o código de 6 dígitos que foi enviado para o seu e-mail.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
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
