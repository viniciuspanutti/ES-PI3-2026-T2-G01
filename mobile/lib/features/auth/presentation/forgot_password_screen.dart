import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/services/auth_service.dart';
import 'package:mobile/widgets/custom_continue_button_widget.dart';
import 'package:mobile/widgets/custom_back_arrow_widget.dart';
import 'package:mobile/widgets/custom_email_field_widget.dart';
import 'package:mobile/features/auth/presentation/email_sent_confirmation_screen.dart';

class RecuperarSenha extends StatefulWidget {
  const RecuperarSenha({super.key});

  @override
  State<RecuperarSenha> createState() => _RecuperarSenhaState();
}

class _RecuperarSenhaState extends State<RecuperarSenha> {
  final emailController = TextEditingController();

  // ── INTEGRAÇÃO FIREBASE AUTH ───────────────────────────────────────
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  /// Envia o e-mail de recuperação via Firebase Auth.
  Future<void> _recuperarSenha() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      _showError('Informe seu e-mail.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.resetPassword(emailController.text);

      if (!mounted) return;

      // Navega para a tela de confirmação
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EmailEnviado()),
      );
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
      body: Center(
        child: Center(
          child: Column(
            children: [

              SetaVoltar(
                ontap: () {
                  Navigator.maybePop(context);
                }
              ),

              SizedBox(height: 10,),

              Expanded(
                child: Container(
                  color: Colors.grey[350],
                  child: Center(
                    child: Container(
                      width: 350,
                      height: 600,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(30),
                      child: Row(
                        children: [
                            Expanded(
                              child: Column(
                                children: [

                                  SizedBox(height: 20,),

                                  Text(
                                    'Recuperar Senha',
                                    style: GoogleFonts.lora(
                                    color: Colors.purple[900],
                                    fontSize: 34,
                                    )
                                  ),
                              
                                  SizedBox(height: 60,),
                              
                                  Text(
                                    'Para continuar, \ndigite seu e-mail',
                                    style: GoogleFonts.lora(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    )
                                  ),

                                  SizedBox(height: 20,),
                              
                                  CampoDeEmail(
                                    controller: emailController, 
                                    hintText: 'Minhaconta@gmail.com', 
                                    obscureText: false,
                                    ),

                                  SizedBox(height: 120,),

                                  // ── BOTÃO COM ESTADO DE CARREGAMENTO ──
                                  _isLoading
                                      ? const CircularProgressIndicator(
                                          color: Color(0xFF512DA8),
                                        )
                                      : BotaoRecuperar(
                                          onTap: _recuperarSenha,
                                        ),

                                  
                                ]
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}