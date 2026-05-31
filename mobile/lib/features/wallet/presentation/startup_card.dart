

import 'package:flutter/material.dart'; // Biblioteca base do Flutter (permite usar widgets como GestureDetector, Container, ClipRRect).
import 'package:google_fonts/google_fonts.dart'; // Biblioteca de fontes (permite usar GoogleFonts.montserrat).
import '../asset_details_screen.dart'; // Importa a tela de detalhes (permite navegar para AssetDetailsScreen).

/**
 * CLASSE: StartupCard
 * TIPO: StatelessWidget (Widget Fixo/Estático)
 * O QUE FAZ: Este componente desenha o cartão individual de cada startup na lista do balcão.
 * Ele mostra o logo, ticker, nome, preço atual, valorização e o saldo do usuário.
 */
class StartupCard extends StatelessWidget {
  final Map<String, dynamic> startup;
  final double total;
  //total é o valor total do startup=quantidade de tokens x preço do token 

  const StartupCard({
    super.key,
    required this.startup,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    //este widget é usado para criar uma cartão de startup 
    //ele contém as informações do startup, como nome, logo, preço, quantidade de tokens, valor total 
    //e um botão para ver detalhes 
    //quando o usuário clica no botão, ele é levado para a tela de detalhes do startup 
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AssetDetailsScreen(startup: startup),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16), // Espaço de 16 pixels entre um cartão e outro.
        padding: const EdgeInsets.all(16), // Espaço interno dentro do cartão.
        decoration: BoxDecoration(
          color: Colors.white, // Fundo branco.
          borderRadius: BorderRadius.circular(20), // Cantos bem arredondados (estilo moderno).
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04), // Sombra muito suave para profundidade.
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                // 1. LOGO DA STARTUP (Imagem ou ícone de fallback)
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: startup['logo'].toString().startsWith('http')
                        ? Image.network(
                            startup['logo'], // Se for um link da internet.
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.business, color: Colors.grey),
                          )
                        : Image.asset(
                            'assets/images/logos/${startup['logo']}', // Se for uma imagem local.
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                                  startup['logo'],
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.business, color: Colors.grey),
                                ),
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                // 2. NOME E TICKER (Identificação)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        startup['ticker'], // Ex: AGRI3
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        startup['nome'], // Ex: AgriSense
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                // 3. PREÇO E VALORIZAÇÃO (Dados financeiros)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'R\$ ${startup['preco'].toStringAsFixed(2)}', // Preço formatado com 2 casas decimais.
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      startup['valorizacao'], // Porcentagem (ex: +2.5%)
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: Colors.green, // DICA: Pode ser condicional para mudar de cor.
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(height: 24), // Linha cinza clara separando o topo do rodapé do card.
            // 4. SALDO E VALOR TOTAL (Resumo do investimento do usuário)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Qtd: ${startup['qtd']}', // Quantidade de tokens que o usuário possui.
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  'Total: R\$ ${total.toStringAsFixed(2)}', // Patrimônio total nesta startup.
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF512DA8), // Roxo oficial do app.
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
