import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/features/home/componentes/btn_home.dart';
import 'package:mobile/features/home/componentes/btn_login_senha.dart';
import 'package:mobile/features/home/componentes/campo_de_texto.dart';
import 'package:mobile/features/home/componentes/seta_voltar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void loginUser() {}

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
                    Navigator.pushNamed(context, '/menu');
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
                  'lib/features/home/images/perfil.png',
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
                        'lib/features/home/images/Checkmark.png',
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

                Text.rich(
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

                const SizedBox(height: 30,),

                BotaoLogin(
                  onTap: loginUser,
                )
                
            ],),
          ),
        ),
      ),
    );
  }
}
