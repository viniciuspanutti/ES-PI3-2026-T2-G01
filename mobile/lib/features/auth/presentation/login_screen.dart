import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/services/auth_service.dart';
import 'package:mobile/widgets/custom_login_button_widget.dart';
import 'package:mobile/widgets/custom_text_field_widget.dart';
import 'package:mobile/widgets/custom_back_arrow_widget.dart';
import 'package:mobile/widgets/custom_forgot_password_button_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loginUser() async {
    final email = usernameController.text.trim();
    final password = passwordController.text;

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

      // CORREÇÃO FINAL: Como o StreamBuilder no main.dart já trocou o root 
      // para MainWrapperScreen, basta dar um pop na tela de login para "revelá-lo".
      if (!mounted) return;
      Navigator.of(context).pop(); 
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true, 
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              children: [
                SetaVoltar(ontap: () => Navigator.maybePop(context)),
                Divider(thickness: 0.5, color: Colors.grey[400]),
                const SizedBox(height: 10),
                Text(
                  'Fazer o Login',
                  style: GoogleFonts.lora(fontSize: 30, color: Colors.purple[900]),
                ),
                const SizedBox(height: 20),
                Image.asset('assets/images/perfil.png', height: 120),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, bottom: 10), 
                      child: Text('E-mail', style: GoogleFonts.lora(fontSize: 20)),
                    ),
                  ],
                ),
                CampoDeTexto(
                  controller: usernameController,
                  hintText: 'Minhaconta@gmail.com',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, bottom: 10), 
                      child: Text('Senha', style: GoogleFonts.lora(fontSize: 20)),
                    ),
                  ],
                ),
                CampoDeTexto(
                  controller: passwordController,
                  hintText: 'Senha',
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                MudarSenha(
                  onTap: () => Navigator.pushNamed(context, '/recuperarsenha'),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Image.asset('assets/images/Checkmark.png', width: 25),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Lembrar de mim',
                        style: GoogleFonts.lora(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Divider(thickness: 0.5, color: Colors.grey[400]),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/cadastro'),
                  child: Text.rich(
                    TextSpan(
                      text: 'Não tenho cadastro. ',
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Cadastrar',
                          style: TextStyle(color: Colors.blue[600], fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                _isLoading
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: CircularProgressIndicator(color: Color(0xFF512DA8)),
                      )
                    : BotaoLogin(onTap: loginUser),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
