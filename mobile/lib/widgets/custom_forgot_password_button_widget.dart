import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MudarSenha extends StatelessWidget {
  final void Function()? onTap;

  const MudarSenha({
    super.key, 
    required this.onTap
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 30, bottom: 10), 
            child: Text(
              'Esqueci minha senha',
              style: GoogleFonts.lora(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationThickness: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
