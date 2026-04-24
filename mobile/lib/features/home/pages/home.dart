import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/features/home/componentes/btn_cadastrar.dart';
import 'package:mobile/features/home/componentes/btn_login.dart';

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({super.key});

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 130),

              Image.asset('lib/features/home/images/cartao.png'),

              SizedBox(height: 40),

              Text(
                'Começar a Investir',
                style: GoogleFonts.lora(
                  fontSize: 34,
                  color: Colors.purple[900],
                ),
              ),

              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.only(left: 60, right: 60),
                child: Text(
                  'Crie sua nova conta ou entre em uma conta já existente.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lora(fontSize: 18, color: Colors.black),
                ),
              ),

              SizedBox(height: 80),

              Divider(thickness: 0.5, color: Colors.grey[400]),

              SizedBox(height: 20),

              // ── Navega para a tela de cadastro ─────────────────────
              BotaoCadastrar(
                onTap: () {
                  Navigator.pushNamed(context, '/cadastro');
                },
              ),

              SizedBox(height: 20),

              // ── Navega para a tela de login ────────────────────────
              FazerLogin(
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
