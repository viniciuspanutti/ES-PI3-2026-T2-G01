// Tom Bean
// importa o pacote Material Design do Flutter
import 'package:flutter/material.dart';
// importa o pacote Google Fonts para fontes customizadas
import 'package:google_fonts/google_fonts.dart';

// classe Stateless para o botão de login
class BotaoLogin extends StatelessWidget {
  // função callback acionada quando o botão é tocado
  final Function()? onTap;

  // construtor que recebe o callback onTap obrigatoriamente
  const BotaoLogin({super.key, required this.onTap});

  // método que constrói a interface do widget
  @override
  Widget build(BuildContext context) {
    // GestureDetector para capturar gestos de toque
    return GestureDetector(
      onTap: onTap,
      // Container para aplicar estilos customizados
      child: Container(
        // adiciona preenchimento interno no container
        padding: EdgeInsets.all(15),
        // adiciona margem (espaço externo) ao redor do container
        margin: EdgeInsets.symmetric(horizontal: 25),
        // BoxDecoration para estilizar a aparência do container
        decoration: BoxDecoration(
          // define a cor de fundo como roxo escuro
          color: Colors.purple[900],
          // aplica cantos arredondados ao container
          borderRadius: BorderRadius.circular(30),
        ),
        // centraliza os widgets filhos
        child: Center(
          // exibe o texto do botão
          child: Text(
            'Entrar na conta',
            // aplica a fonte Lora com estilo customizado
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
