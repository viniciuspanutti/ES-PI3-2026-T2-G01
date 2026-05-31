// Tom Bean
// importa material design
import 'package:flutter/material.dart';
// importa fontes do Google
import 'package:google_fonts/google_fonts.dart';
// importa serviço de autenticação local
import 'package:mobile/services/auth_service.dart';
// importa botão de continuar customizado
import 'package:mobile/widgets/custom_continue_button_widget.dart';
// importa widget de seta de voltar
import 'package:mobile/widgets/custom_back_arrow_widget.dart';
// importa campo de e-mail customizado
import 'package:mobile/widgets/custom_email_field_widget.dart';
// importa tela de confirmação de e-mail
import 'package:mobile/features/auth/presentation/email_sent_confirmation_screen.dart';

// Tela de recuperação de senha (envia e-mail de reset)
class RecuperarSenha extends StatefulWidget {
  const RecuperarSenha({super.key});

  @override
  State<RecuperarSenha> createState() => _RecuperarSenhaState();
}

class _RecuperarSenhaState extends State<RecuperarSenha> {
  // controlador do campo de e-mail
  final emailController = TextEditingController();

  // INTEGRAÇÃO FIREBASE AUTH -------------------------------------
  // instância do serviço de autenticação
  final AuthService _authService = AuthService();
  // flag de carregamento para mostrar spinner
  bool _isLoading = false;

  // libera o controller ao desmontar o widget
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  /// envia requisição de recuperação de senha via AuthService
  Future<void> _recuperarSenha() async {
    // obtém e-mail digitado
    final email = emailController.text.trim();

    // valida se foi preenchido
    if (email.isEmpty) {
      _showError('Informe seu e-mail.');
      return;
    }

    // mostra indicador de carregamento
    setState(() => _isLoading = true);

    try {
      // solicita reset de senha ao serviço
      await _authService.resetPassword(emailController.text);

      if (!mounted) return;

      // navega para tela de confirmação de envio de e-mail
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EmailEnviado()),
      );
    } catch (e) {
      // em caso de erro mostra snackbar
      if (!mounted) return;
      _showError(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      // sempre remove o estado de carregamento
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // mostra erro em snackbar
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Center(
          child: Column(
            children: [

              // seta de voltar que faz pop na pilha
              SetaVoltar(
                ontap: () {
                  Navigator.maybePop(context);
                }
              ),

              SizedBox(height: 10,),

              // cartão central contendo formulário resumido
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

                                  // título da seção
                                  Text(
                                    'Recuperar Senha',
                                    style: GoogleFonts.lora(
                                    color: Colors.purple[900],
                                    fontSize: 34,
                                    )
                                  ),
                              
                                  SizedBox(height: 60,),
                              
                                  // instrução para digitar e-mail
                                  Text(
                                    'Para continuar, \ndigite seu e-mail',
                                    style: GoogleFonts.lora(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    )
                                  ),

                                  SizedBox(height: 20,),
                              
                                  // campo de e-mail
                                  CampoDeEmail(
                                    controller: emailController, 
                                    hintText: 'Minhaconta@gmail.com', 
                                    obscureText: false,
                                    ),

                                  SizedBox(height: 120,),

                                  // botão de continuar ou indicador de loading
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