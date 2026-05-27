import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BotaoRecuperar extends StatelessWidget {
  final Function()? onTap;

  const BotaoRecuperar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.purple[900],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            'Continuar',
            style: GoogleFonts.lora(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
