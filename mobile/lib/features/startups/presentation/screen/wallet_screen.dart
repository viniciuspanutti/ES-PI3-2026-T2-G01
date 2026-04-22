
import 'package:flutter/material.dart';

// Definindo a classe da tela como um StatelessWidget (tela que não muda de estado sozinha)
class CarteiraBalcaoScreen extends StatelessWidget {
  const CarteiraBalcaoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Definindo constantes de cores para manter o padrão visual do MesclaInvest
    const Color roxoMescla = Color(0xFF512DA8);
    const Color fundoCinza = Color(0xFFF5F5F5);

    // Lista de Mapas: Simula os dados que viriam do seu Firebase/Backend
    final List<Map<String, dynamic>> transacoes = [
      {'titulo': 'Transferência', 'sub': 'To: 0x38dc...b037', 'valor': '93 BYD', 'icon': Icons.send},
      {'titulo': 'Compra', 'sub': 'To: 0x7131...8b6a', 'valor': '23.4 BYD', 'icon': Icons.shopping_cart},
      {'titulo': 'Recebido', 'sub': 'Address: 0x4d1e...c37C', 'valor': '57 BYD', 'icon': Icons.swap_vert},
      {'titulo': 'Recebido', 'sub': 'To: 0x38dc...b037', 'valor': '12.2 BYD', 'icon': Icons.send},
    ];

    return Scaffold(
      backgroundColor: fundoCinza, // Define a cor de fundo da tela inteira
      appBar: AppBar(
        // leading: O que aparece no início da barra (botão de voltar)
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context), // Comando para fechar a tela e voltar
        ),
        title: const Text('Voltar', style: TextStyle(color: Colors.black, fontSize: 18)),
        backgroundColor: Colors.transparent, // Barra transparente para um look moderno
        elevation: 0, // Remove a sombra da barra superior
      ),
      // CustomScrollView: Permite criar uma tela onde partes diferentes rolam juntas
      body: CustomScrollView(
        slivers: [
          // SliverToBoxAdapter: Permite colocar widgets comuns (como Column) dentro do ScrollView
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text('\$1.297,67  +0.75%',
                            style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                      const SizedBox(height: 10), // Espaçamento vertical
                      const Text('BYD', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, letterSpacing: 2)),
                      const SizedBox(height: 10),
                      const Text('345.71 BYD',
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: roxoMescla)),
                      Text('R\$ 2.107,34', style: TextStyle(color: Colors.grey[600], fontSize: 16)),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Linha com os botões circulares de ação
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribui os botões por igual
                  children: [
                    _buildCircularAction(Icons.show_chart, 'Comprar'),
                    _buildCircularAction(Icons.swap_horiz, 'Trocar'),
                    _buildCircularAction(Icons.send, 'Enviar'),
                    _buildCircularAction(Icons.file_download, 'Receber'),
                  ],
                ),
                const SizedBox(height: 40),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Hoje', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          
          // SliverPadding: Dá margem para a lista de transações
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            // SliverList: A versão da ListView para dentro de um CustomScrollView
            sliver: SliverList(
              // delegate: O "gerente" que constrói os itens conforme o usuário rola a tela
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = transacoes[index]; // Pega os dados da transação atual
                  return Card(
                    elevation: 1, // Sombra leve embaixo do card
                    margin: const EdgeInsets.only(bottom: 12), // Espaço entre os cards
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: Icon(item['icon'], color: Colors.greenAccent), // Ícone à esquerda
                      title: Text(item['titulo'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(item['sub']), // Texto pequeno abaixo do título
                      trailing: Text(item['valor'], style: const TextStyle(fontWeight: FontWeight.bold)), // Texto à direita
                      onTap: () {
                        // Função disparada ao clicar na transação
                        print("Clicou na transação: ${item['titulo']}");
                      },
                    ),
                  );
                },
                childCount: transacoes.length, // Diz ao Flutter quantos itens existem
              ),
            ),
          ),
        ],
      ),
      // Barra de navegação inferior arredondada
      bottomNavigationBar: _buildBottomNav(roxoMescla),
    );
  }

  // Função Auxiliar: Cria o botão circular com ícone e texto
  Widget _buildCircularAction(IconData icon, String label) {
    return InkWell(
      onTap: () => print("Clicou em $label"), // Efeito visual de clique + ação
      borderRadius: BorderRadius.circular(50),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle, // Transforma o Container num círculo
            ),
            child: Icon(icon, color: Colors.black, size: 24),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  // Função Auxiliar: Constrói a barra de navegação personalizada (estilo flutuante)
  Widget _buildBottomNav(Color activeColor) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20), // Margens para parecer flutuante
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF222222), // Fundo quase preto
        borderRadius: BorderRadius.circular(40), // Bordas bem arredondadas
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.home_filled, color: Colors.white70),
          const Icon(Icons.search, color: Colors.white70),
          // Botão de destaque "Balcão"
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: activeColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.account_balance_wallet, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text('Balcão', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Icon(Icons.person_outline, color: Colors.white70),
        ],
      ),
    );
  }
}
