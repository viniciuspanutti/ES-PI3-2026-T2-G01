// Tom Bean
// importa widgets base do Flutter
import 'package:flutter/material.dart';
// importa fontes do Google
import 'package:google_fonts/google_fonts.dart';
// importa serviço de autenticação local
import 'package:mobile/services/auth_service.dart';
// importa botão de login customizado
import 'package:mobile/widgets/custom_login_button_widget.dart';
// importa widget de 'esqueci senha'
import 'package:mobile/widgets/custom_forgot_password_button_widget.dart';
// importa gerador de números aleatórios
import 'dart:math';
// importa Firebase Auth
import 'package:firebase_auth/firebase_auth.dart';
// importa armazenamento local para preferências
import 'package:shared_preferences/shared_preferences.dart';
// importa serviço de envio de e-mails
import 'package:mobile/core/services/email_service.dart';
// importa rotas da aplicação
import 'package:mobile/core/routes/app_routes.dart';
// importa campo de texto customizado
import 'package:mobile/widgets/custom_text_field_widget.dart';
// importa widget de seta de voltar
import 'package:mobile/widgets/custom_back_arrow_widget.dart';

// Declaração do widget de tela de login
class LoginPage extends StatefulWidget {
  // construtor padrão
  const LoginPage({super.key});

  // cria o estado associado
  @override
  State<LoginPage> createState() => _LoginPageState();
}

// Estado da tela de login
class _LoginPageState extends State<LoginPage> {
  // controlador para o campo de e-mail
  final usernameController = TextEditingController();
  // controlador para o campo de senha
  final passwordController = TextEditingController();

  // INTEGRAÇÃO FIREBASE AUTH -------------------------------------
  // instância do serviço de autenticação local
  final AuthService _authService = AuthService();
  // flag que indica se está carregando
  bool _isLoading = false;
  // flag para o checkbox "lembrar de mim"
  bool _rememberMe = false;
  // controla exibição/ocultação da senha
  bool _obscurePassword = true;

  // libera recursos dos controllers
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// Função que realiza o login usando Firebase Auth
  Future<void> loginUser() async {
    // obtém e-mail e senha dos controllers
    final email = usernameController.text.trim();
    final password = passwordController.text;

    // validação simples de campos vazios
    if (email.isEmpty || password.isEmpty) {
      _showError('Preencha todos os campos.');
      return;
    }

    // marca como carregando
    setState(() => _isLoading = true);

    try {
      // solicita autenticação ao serviço
      await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // evita atualizações após o widget ser desmontado
      if (!mounted) return;

      // obtém usuário atual do Firebase
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // verifica se o usuário tem MFA ativado nas prefs locais
        final prefs = await SharedPreferences.getInstance();
        final isMfaEnabled = prefs.getBool('mfa_enabled_${user.uid}') ?? false;

        if (isMfaEnabled) {
          // gera código aleatório de 6 dígitos
          final random = Random();
          final code = (100000 + random.nextInt(900000)).toString();

          if (!mounted) return;
          // mostra snackbar informando envio do código
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Enviando código para seu e-mail...'),
              backgroundColor: Colors.blue.shade700,
            ),
          );

          try {
            // envia OTP por e-mail
            await EmailService.sendOTP(email, code);
          } catch (e) {
            // em caso de erro no envio, mostra mensagem e aborta
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
              _showError('Erro no envio do e-mail: $e');
            }
            return; // interrompe fluxo sem navegar
          }

          if (!mounted) return;
          // remove estado de carregamento
          setState(() {
            _isLoading = false;
          });
          // navega para tela de MFA passando o código
          Navigator.pushNamed(context, AppRoutes.mfa, arguments: code);
          return;
        }
      }

      // Navegação pós-login sem MFA: vai para rota principal e limpa histórico
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mainRoute, (route) => false);
    } catch (e) {
      // mostra erro amigável ao usuário
      if (!mounted) return;
      _showError(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      // garante que o spinner seja removido
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // exibe erro em snackbar
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
  // FIM DA INTEGRAÇÃO ----------------------------------------------

  // constrói a interface da tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // fundo branco
      // evita que o teclado sobreponha campos
      resizeToAvoidBottomInset: true, 
      body: SafeArea(
        child: SingleChildScrollView( // permite rolagem quando o teclado aparece
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              children: [
                // seta de voltar no topo
                SetaVoltar(
                  ontap: () {
                    Navigator.maybePop(context);
                  }
                ),

                // linha divisória
                Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),

                const SizedBox(height: 10,),

                // título da tela
                Text(
                  'Fazer o Login',
                  style: GoogleFonts.lora(
                    fontSize: 30,
                    color: Colors.purple[900],
                  ),
                ),

                const SizedBox(height: 20,),

                // imagem de perfil/ilustração
                Image.asset(
                  'assets/images/perfil.png',
                  height: 120, // Altura fixa para o layout
                ),

                const SizedBox(height: 30,),

                // rótulo do campo e-mail
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

                // campo de entrada para e-mail
                CampoDeTexto(
                  controller: usernameController,
                  hintText: 'Minhaconta@gmail.com',
                  obscureText: false,
                ),

                const SizedBox(height: 10,),

                // rótulo do campo senha
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

                // campo de entrada para senha com ícone de visibilidade
                CampoDeTexto(
                  controller: passwordController,
                  hintText: 'Senha',
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey[700],
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 30,),

                // link para recuperar senha
                MudarSenha(
                  onTap: () {
                    Navigator.pushNamed(context, '/recuperarsenha');
                  }
                ),

                const SizedBox(height: 30,),

                // checkbox para lembrar usuário
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: _rememberMe,
                          activeColor: const Color(0xFF512DA8),
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value!;
                            });
                          },
                        ),
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

                // divisor visual
                Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),

                const SizedBox(height: 20,),

                // link para tela de cadastro
                GestureDetector(
                  onTap: () {
                    // Navega para a tela de cadastro
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
                        ),
                      )
                    ]
                    )
                  ),
                ),

                const SizedBox(height: 30,),

                // botão de login ou indicador de carregamento
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
