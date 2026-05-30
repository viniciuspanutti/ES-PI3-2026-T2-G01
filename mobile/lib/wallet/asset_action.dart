// feito por camila fernandes costacurta RA:25012949

import 'package:flutter/material.dart'; // Biblioteca base do Flutter (permite usar widgets como InkWell, Column, CircleAvatar).


/**
 * CLASSE: AssetActionButton
 * TIPO: StatelessWidget (Widget Fixo/Estático)
 * O QUE FAZ: Este é um componente reutilizável que cria um botão de ação circular 
 * com um ícone e um texto embaixo. Ele é usado para ações como "Investir" ou "Trocar".
 */
class AssetActionButton extends StatelessWidget {
  // PROPRIEDADES (O que o botão precisa receber para ser criado)
  final IconData icon; // O ícone que vai aparecer no centro do círculo (ex: Icons.add).
  final String label;  // O texto/rótulo que vai aparecer embaixo do ícone (ex: "Investir").
  final VoidCallback onTap; // A função/ação que será executada quando o usuário clicar no botão.

  // CONSTRUTOR: Define quais dados são obrigatórios para este botão existir.
  const AssetActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  /**
   * MÉTODO: build
   * O QUE FAZ: Desenha o visual do botão na tela.
   * ESTRUTURA:
   * - InkWell: Detecta o toque e cria aquele efeito visual de "clique".
   * - Column: Organiza o círculo (ícone) e o texto um embaixo do outro.
   * - CircleAvatar: Cria o fundo circular cinza para o ícone.
   */
  @override
  Widget build(BuildContext context) {
    return InkWell( // Widget que detecta o clique e adiciona um efeito visual de toque.
      onTap: onTap, // Executa a função recebida no construtor.
      borderRadius: BorderRadius.circular(28), // Garante que o efeito de clique seja arredondado.
      child: Column( // Organiza o ícone e o texto em uma coluna vertical.
        children: [
          CircleAvatar( // Cria o componente circular (avatar/ícone).
            radius: 28, // Define o tamanho do círculo (raio de 28 pixels).
            backgroundColor: Colors.grey[100], // Define o fundo cinza bem clarinho.
            child: Icon(icon, color: Colors.black), // Coloca o ícone no centro com cor preta.
          ), // Fim do círculo.
          const SizedBox(height: 8), // Adiciona um espaço de 8 pixels entre o círculo e o texto.
          Text( // Widget de texto para o rótulo do botão.
            label, // O texto (ex: "Investir").
            style: const TextStyle( // Estilo do texto.
              fontSize: 12, // Tamanho da letra 12.
              fontWeight: FontWeight.w500, // Peso da fonte médio (quase negrito).
            ), // Fim do estilo.
          ), // Fim do texto.
        ], // Fim dos filhos da coluna.
      ), // Fim da coluna.
    ); // Fim do InkWell.
  } // Fim do método build.
} // Fim da classe AssetActionButton.
