// Tom Bean
// importa material design do Flutter
import 'package:flutter/material.dart';
// importa fontes do Google
import 'package:google_fonts/google_fonts.dart';
// importa rotas da aplicação (usado para navegar de volta ao login)
import 'package:mobile/core/routes/app_routes.dart';
// importa botão de voltar ao menu
import 'package:mobile/widgets/custom_back_to_menu_button_widget.dart';
// importa seta de voltar
import 'package:mobile/widgets/custom_back_arrow_widget.dart';

// Tela que informa que o e-mail de recuperação foi enviado
class EmailEnviado extends StatefulWidget {
  const EmailEnviado({super.key});

  @override
  State<EmailEnviado> createState() => _EmailEnviadoState();
}

class _EmailEnviadoState extends State<EmailEnviado> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // fundo branco
      body: Center(
        child: Center(
          child: Column(
            children: [

              // seta de voltar que retorna para tela de recuperação
              SetaVoltar(
                ontap: () {
                  Navigator.pushNamed(context, '/recuperarsenha');
                }
              ),

              SizedBox(height: 10,),

              // área central com cartão contendo a mensagem
              Expanded(
                child: Container(
                  color: Colors.grey[350], // fundo cinza claro
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

                                  // imagem de confirmação
                                  Image.asset('assets/images/feito.png'),

                                  SizedBox(height: 20,),

                                  // texto principal informando envio
                                  Text(
                                    'Enviamos uma confirmação\n para o seu email.',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lora(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    )
                                  ),
                              
                                  SizedBox(height: 30,),
                              
                                  // instrução adicional
                                  Text(
                                    'Acesse o link que enviamos para\n definir uma nova senha.',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lora(
                                    color: Colors.black,
                                    fontSize: 18,
                                    )
                                  ),

                                  SizedBox(height: 30,),

                                  // link visual para reenviar e-mail (apenas visual aqui)
                                  Text(
                                    'Reenviar e-mail',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lora(
                                      color: const Color.fromARGB(200, 255, 153, 0),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      decorationThickness: 1.5,
                                      decorationColor: Colors.orange,
                                    ),
                                  ),

                                  SizedBox(height: 100,),

                                  // botão que volta ao menu/login
                                  BotaoVoltarMenu(
                                    onTap: (){
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        AppRoutes.login,
                                        (route) => false,
                                      );
                                    }
                                  )
                                  
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