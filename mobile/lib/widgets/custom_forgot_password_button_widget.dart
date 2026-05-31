// Tom Bean
// importa o pacote Material Design do Flutter
import 'package:flutter/material.dart';
// importa o pacote Google Fonts para fontes customizadas
import 'package:google_fonts/google_fonts.dart';

// classe Stateless para o botão de esqueci a senha
class MudarSenha extends StatelessWidget {
  // função callback acionada quando o botão é tocado
  final void Function()? onTap;

  // construtor que recebe o callback onTap obrigatoriamente
  const MudarSenha({
    super.key, 
    required this.onTap
    });

  // método que constrói a interface do widget
  @override
  Widget build(BuildContext context) {
    // GestureDetector para capturar gestos de toque
    return GestureDetector(
      onTap: onTap,
      // Row organiza os filhos horizontalmente
      child: Row(
        children: [
          // Padding adiciona espaçamento ao redor do texto
          Padding(
            padding: EdgeInsets.only(left: 30, bottom: 10), 
            // exibe o texto de esqueci a senha
            child: Text(
              'Esqueci minha senha',
              // aplica a fonte Lora com estilo customizado
              style: GoogleFonts.lora(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                // adiciona decoração de sublinhado ao texto
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
