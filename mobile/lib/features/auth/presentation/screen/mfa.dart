import 'package:flutter/material.dart'; // Importa o pacote básico de interface do Flutter.

class MfaScreen extends StatelessWidget { // Define a tela de Verificação de Segurança (MFA).
  const MfaScreen({super.key}); // Construtor para identificação do widget na árvore.

  @override
  Widget build(BuildContext context) { // Constrói o visual da tela de autenticação.
    return Scaffold( // Cria a base da página com suporte a fundo e barras.
      backgroundColor: Colors.white, // Define a cor de fundo da tela como branco.
      appBar: AppBar( // Configura a barra superior com o nome do app.
        backgroundColor: Colors.white, // Deixa a barra superior branca.
        elevation: 0, // Remove a sombra projetada pela barra superior.
        title: const Text( // Define o texto do título da barra.
          'MesclaInvest',
          style: TextStyle(
            color: Color(0xFF673AB7), // Aplica o roxo da marca no título.
            fontWeight: FontWeight.bold, // Deixa o título em negrito.
          ),
        ),
        centerTitle: true, // Centraliza o nome do app na barra superior.
        bottom: PreferredSize( // Adiciona uma linha fina abaixo da barra superior.
          preferredSize: const Size.fromHeight(1.0), // Define a altura da linha como 1 pixel.
          child: Container(color: Colors.grey[300], height: 1.0), // Pinta a linha de cinza claro.
        ),
      ),
      body: Padding( // Adiciona um espaçamento em volta de todo o conteúdo.
        padding: const EdgeInsets.symmetric(horizontal: 30), // Define 30 pixels de margem nas laterais.
        child: Column( // Organiza os textos e campos verticalmente.
          crossAxisAlignment: CrossAxisAlignment.start, // Alinha os textos à esquerda.
          children: [
            const SizedBox(height: 40), // Pula um espaço de 40 pixels no topo.
            const Text( // Texto de instrução principal da tela.
              'verificação de\nsegurança',
              style: TextStyle(
                color: Color(0xFF673AB7), // Texto na cor roxa da identidade visual.
                fontSize: 24, // Define o tamanho da fonte da instrução.
                fontWeight: FontWeight.w300, // Deixa a fonte mais fina e elegante.
              ),
            ),
            const SizedBox(height: 30), // Espaço entre o título e a próxima instrução.
            const Text( // Pequeno rótulo para o campo de código.
              'insira o código',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15), // Espaço entre o rótulo e os campos de entrada.
            Row( // Coloca os quadradinhos de código lado a lado.
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribui os campos igualmente na largura.
              children: [
                _buildCodeBox(), // Cria o primeiro campo do código de 4 dígitos.
                _buildCodeBox(), // Cria o segundo campo do código.
                _buildCodeBox(), // Cria o terceiro campo do código.
                _buildCodeBox(), // Cria o quarto campo do código.
              ],
            ),
            const SizedBox(height: 40), // Espaço antes do botão de confirmação.
            SizedBox( // Define o tamanho e formato do botão de verificar.
              width: double.infinity, // Faz o botão ocupar toda a largura disponível.
              height: 50, // Define a altura do botão.
              child: ElevatedButton( // Cria o botão pressionável com cor de fundo.
                onPressed: () {}, // Função que será executada ao clicar (vazia por enquanto).
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A2A84), // Cor roxa escura para o botão.
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25), // Deixa as pontas do botão arredondadas.
                  ),
                ),
                child: const Text( // Texto dentro do botão.
                  'Verificar',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeBox() { // Função auxiliar que desenha cada quadrado cinza de entrada.
    return Container(
      width: 60, // Largura de cada quadrado de código.
      height: 70, // Altura de cada quadrado de código.
      decoration: BoxDecoration(
        color: Colors.grey[300], // Cor de fundo cinza para o campo.
        borderRadius: BorderRadius.circular(4), // Arredonda levemente os cantos do quadrado.
      ),
      child: const TextField( // Campo onde o usuário digita o número.
        textAlign: TextAlign.center, // Centraliza o número dentro do quadrado.
        keyboardType: TextInputType.number, // Abre apenas o teclado numérico no celular.
        decoration: InputDecoration(border: InputBorder.none), // Remove a linha padrão debaixo do campo.
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Estilo do número digitado.
      ),
    );
  }
}