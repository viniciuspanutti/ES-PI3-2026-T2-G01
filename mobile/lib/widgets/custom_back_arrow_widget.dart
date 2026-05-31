// Tom Bean
// importa o pacote Material Design do Flutter
import 'package:flutter/material.dart';

// classe Stateless para exibir um botão de seta de voltar
class SetaVoltar extends StatelessWidget {
  // função callback executada quando a seta é tocada
  final void Function()? ontap;

  // construtor que recebe o callback ontap obrigatoriamente
  const SetaVoltar({
    super.key,
    required this.ontap,
  });

  // método que constrói a interface do widget
  @override
  Widget build(BuildContext context) {
    // GestureDetector para capturar gestos de toque
    return GestureDetector(
      onTap: ontap,
      // Row organiza os filhos horizontalmente
      child: Row(
        children: [
          // Padding adiciona espaçamento ao redor da imagem da seta
          Padding(
            padding: EdgeInsets.only(left: 20, top: 30),
            // carrega e exibe a imagem da seta de voltar
            child: Image.asset(
              'assets/images/seta.png',
              width: 40,
              height: 40,
            ),
          ),
        ],
      ),
    );
  }
}
