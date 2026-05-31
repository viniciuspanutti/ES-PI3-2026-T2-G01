import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/core/routes/app_routes.dart';
import 'package:mobile/widgets/custom_back_to_menu_button_widget.dart';
import 'package:mobile/widgets/custom_back_arrow_widget.dart';

class EmailEnviado extends StatefulWidget {
  const EmailEnviado({super.key});

  @override
  State<EmailEnviado> createState() => _EmailEnviadoState();
}

class _EmailEnviadoState extends State<EmailEnviado> {

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
                  Navigator.pushNamed(context, '/recuperarsenha');
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

                                  Image.asset('assets/images/feito.png'),

                                  SizedBox(height: 20,),

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
                              
                                  Text(
                                    'Acesse o link que enviamos para\n definir uma nova senha.',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lora(
                                    color: Colors.black,
                                    fontSize: 18,
                                    )
                                  ),

                                  SizedBox(height: 30,),

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