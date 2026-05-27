import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/services/auth_service.dart';
import 'package:mobile/widgets/custom_login_button_widget.dart';
import 'package:mobile/widgets/custom_forgot_password_button_widget.dart';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile/core/services/email_service.dart';
import 'package:mobile/core/routes/app_routes.dart';
import 'package:mobile/widgets/custom_text_field_widget.dart';
import 'package:mobile/widgets/custom_back_arrow_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // ── INTEGRAÇÃO FIREBASE AUTH ───────────────────────────────────────
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// Conecta o botão de login ao Firebase Auth.
  /// Em caso de sucesso, redireciona ao catálogo e impede o botão "Voltar".
  Future<void> loginUser() async {
    final email = usernameController.text.trim();
    final password = passwordController.text;

    // Validação local rápida
    if (email.isEmpty || password.isEmpty) {
      _showError('Preencha todos os campos.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
        final isMfaEnabled = prefs.getBool('mfa_enabled_${user.uid}') ?? false;

        if (isMfaEnabled) {
          final random = Random();
          final code = (100000 + random.nextInt(900000)).toString();

          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Enviando código para seu e-mail...'),
              backgroundColor: Colors.blue.shade700,
            ),
          );

          try {
            await EmailService.sendOTP(email, code);
          } catch (e) {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
              _showError('Erro no envio do e-mail: $e');
            }
            return; // Impede que vá para a próxima tela sem o código enviado
          }

          if (!mounted) return;
          setState(() {
            _isLoading = false;
          });
          Navigator.pushNamed(context, AppRoutes.mfa, arguments: code);
          return;
        }
      }

      // ── Navegação pós-login se não tiver MFA ────────────────────────
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mainRoute, (route) => false);
    } catch (e) {
      if (!mounted) return;
      _showError(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
  // ── FIM DA INTEGRAÇÃO ──────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Redimensiona o conteúdo automaticamente quando o teclado aparece
      resizeToAvoidBottomInset: true, 
      body: SafeArea(
        child: SingleChildScrollView( // Permite rolar a tela e evita a barra amarela de overflow
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              children: [
                SetaVoltar(
                  ontap: () {
                    Navigator.maybePop(context);
                  }
                ),

                Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),

                const SizedBox(height: 10,),

                Text(
                  'Fazer o Login',
                  style: GoogleFonts.lora(
                    fontSize: 30,
                    color: Colors.purple[900],
                  ),
                ),

                const SizedBox(height: 20,),

                Image.asset(
                  'assets/images/perfil.png',
                  height: 120, // Altura fixa para ajudar no layout
                ),

                const SizedBox(height: 30,),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, bottom: 10), 
                      child: Text(
                        'E-mail',
                        style: GoogleFonts.lora(
                          fontSize: 20,
                        ),
                        ),
                    ),
                  ],
                ),

                CampoDeTexto(
                  controller: usernameController,
                  hintText: 'Minhaconta@gmail.com',
                  obscureText: false,
                ),

                const SizedBox(height: 10,),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, bottom: 10), 
                      child: Text(
                        'Senha',
                        style: GoogleFonts.lora(
                          fontSize: 20,
                        ),
                        ),
                    ),
                  ],
                ),

                CampoDeTexto(
                  controller: passwordController,
                  hintText: 'Senha',
                  obscureText: true,
                ),

                const SizedBox(height: 30,),

                MudarSenha(
                  onTap: () {
                    Navigator.pushNamed(context, '/recuperarsenha');
                  }
                ),

                const SizedBox(height: 30,),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Image.asset(
                        'assets/images/Checkmark.png',
                        width: 25,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Lembrar de mim',
                        style: GoogleFonts.lora(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 30,),

                Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),

                const SizedBox(height: 20,),

                GestureDetector(
                  onTap: () {
                    // ── Navega para a tela de cadastro ──────────────
                    Navigator.pushNamed(context, '/cadastro');
                  },
                  child: Text.rich(
                    TextSpan(
                      text: 'Não tenho cadastro. ',
                      style: const TextStyle(
                        color: Colors.black
                      ),
                    children: [
                      TextSpan(
                        text: 'Cadastrar',
                        style: TextStyle(
                          color: Colors.blue[600],
                          fontWeight: FontWeight.bold,
                        )
                      )
                    ]
                    )
                  ),
                ),

                const SizedBox(height: 30,),

                // ── BOTÃO DE LOGIN COM ESTADO DE CARREGAMENTO ────────
                // Enquanto processa, mostra spinner no lugar do botão.
                // ─────────────────────────────────────────────────────
                _isLoading
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: CircularProgressIndicator(
                          color: Color(0xFF512DA8),
                        ),
                      )
                    : BotaoLogin(
                        onTap: loginUser,
                      ),
                
            ],),
          ),
        ),
      ),
    );
  }
}
