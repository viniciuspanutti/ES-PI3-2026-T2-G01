import 'package:flutter/material.dart'; // Importa a biblioteca visual base do Flutter.
import '../../data/exchange_service.dart'; // Ajuste o 'seu_projeto'
import '../../data/simple_transaction_service.dart'; // Serviço simples de transações
import 'package:mobile/core/routes/app_routes.dart';
import 'sell_dialog.dart';

class CarteiraBalcaoScreen extends StatelessWidget { // Define a tela como um componente que não muda de estado.
  
  const CarteiraBalcaoScreen({super.key}); // Construtor padrão para identificar o widget.

  @override
  Widget build(BuildContext context) { // Função principal que desenha a interface na tela.
    
    const Color roxoMescla = Color(0xFF512DA8); // Define a cor roxa principal da identidade visual.
    const Color fundoCinza = Color(0xFFF5F5F5); // Define a cor cinza clara para o fundo da página.

    return Scaffold( // Estrutura base que organiza os elementos da tela.
      backgroundColor: fundoCinza, // Aplica a cor de fundo cinza em toda a tela.
      appBar: AppBar( // Cria a barra superior de navegação.
        leading: IconButton( // Define o botão que fica no canto esquerdo da barra.
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Ícone de seta para voltar.
          onPressed: () => Navigator.pop(context), // Comando para fechar a tela atual e voltar à anterior.
        ),
        title: const Text('Voltar', style: TextStyle(color: Colors.black, fontSize: 18)), // Texto da barra superior.
        backgroundColor: Colors.transparent, // Deixa o fundo da barra invisível.
        elevation: 0, // Remove a sombra embaixo da barra superior.
      ),
      body: SingleChildScrollView( // Permite rolar a tela se o conteúdo for maior que o visor.
        child: Column( // Organiza os elementos um abaixo do outro.
          children: [
            Padding( // Adiciona espaçamento interno nas laterais do cabeçalho.
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  const Align( // Alinha o texto de variação financeira à direita.
                    alignment: Alignment.centerRight,
                    child: Text('\$1.297,67  +0.75%', 
                      style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                  const SizedBox(height: 10), // Cria um espaço vertical de 10 pixels.
                  const Text('BYD', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, letterSpacing: 2)), // Nome da moeda em destaque.
                  const SizedBox(height: 10),
                  const Text('345.71 BYD', // Exibe o saldo principal em quantidade de moedas.
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: roxoMescla)),
                  Text('R\$ 2.107,34', style: TextStyle(color: Colors.grey[600], fontSize: 16)), // Exibe o saldo convertido em Reais.
                ],
              ),
            ),

            const SizedBox(height: 30),

            Row( 
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                children: [
                  _buildCircularAction(
                    icon: Icons.show_chart, 
                    label: 'Comprar',
                    onTap: () async {
                      print("🔥 Botão pressionado! Iniciando comunicação com o backend...");
                      try {
                        String idDaStartup = '5bfozOLJ0a93No2wuWni'; 
                        int quantidade = 10;
                        double precoSimulado = 6.09;
                        
                        await ExchangeService().buyTokens(idDaStartup, quantidade);
                        
                        // Registrar transação local para atualização em tempo real
                        SimpleTransactionService().addTransaction(
                          type: 'COMPRA',
                          amount: quantidade.toString(),
                          price: precoSimulado,
                        );
                        
                        print("✅ Sucesso! O backend autorizou a compra.");
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Compra realizada com sucesso!'), backgroundColor: Colors.green),
                          );
                        }
                      } catch (e) {
                        print("❌ Erro retornado pelo backend: $e");
                      }
                    },
                  ), 
                  _buildCircularAction(
                    icon: Icons.trending_down, 
                    label: 'Vender',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const SellTokensDialog(
                          startupId: '5bfozOLJ0a93No2wuWni',
                          startupName: 'BYD',
                          ownedTokens: 345, // Simulação
                          currentPrice: 6.09,
                        ),
                      );
                    },
                  ),
                  _buildCircularAction(icon: Icons.swap_horiz, label: 'Trocar', onTap: () {}), 
                  _buildCircularAction(icon: Icons.send, label: 'Enviar', onTap: () {}), 
                ],
              ),

              const SizedBox(height: 40),

              // Acesso rápido a funcionalidades
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Acesso Rápido', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildQuickAccessButton(
                            context,
                            'Dashboard',
                            Icons.trending_up,
                            Colors.blue,
                            () => Navigator.pushNamed(context, AppRoutes.dashboard),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildQuickAccessButton(
                            context,
                            'Histórico',
                            Icons.history,
                            Colors.green,
                            () => Navigator.pushNamed(context, AppRoutes.historico),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              Padding( // Área do histórico de movimentações.
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Hoje', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, AppRoutes.historico),
                          child: Text(
                            'Ver tudo',
                            style: TextStyle(
                              color: roxoMescla,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    // Lista de transações real e reativa
                    ValueListenableBuilder<List<Map<String, dynamic>>>(
                      valueListenable: SimpleTransactionService().transactionsNotifier,
                      builder: (context, transactions, child) {
                        if (transactions.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text('Nenhuma transação hoje', style: TextStyle(color: Colors.grey)),
                            ),
                          );
                        }
                        
                        // Pegar as 4 transações mais recentes
                        final recentTransactions = transactions.take(4).toList();
                        
                        return Column(
                          children: recentTransactions.map((tx) {
                            return _buildTransactionTile(
                              tx['type'],
                              tx['type'] == 'COMPRA' ? 'Compra de Tokens' : 'Venda de Tokens',
                              '${tx['amount']} BYD',
                              tx['type'] == 'COMPRA' ? Icons.shopping_cart : Icons.trending_down,
                              tx['type'] == 'COMPRA' ? Colors.greenAccent : Colors.redAccent,
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, roxoMescla), // Chama a barra de navegação customizada no rodapé.
    );
  }


  // Alteramos a assinatura da função para receber a ação onTap
  Widget _buildCircularAction({required IconData icon, required String label, required VoidCallback onTap}) { 
    return GestureDetector(
      onTap: onTap, // Ativa o toque no Flutter
      child: Column(
        children: [
          Container( 
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.black, size: 24),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)), 
        ],
      ),
    );
  }

  Widget _buildQuickAccessButton(BuildContext context, String label, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(Color roxoMescla) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: roxoMescla,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: roxoMescla.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Saldo Disponível',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'R\$ 1.500,00',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, Color roxoMescla) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildCircularAction(
            icon: Icons.show_chart,
            label: 'Comprar',
            onTap: () async {
              // Simulação de compra simples conforme escopo
              SimpleTransactionService().addTransaction(
                type: 'COMPRA',
                amount: '10', // Quantidade fixa para simplicidade
                price: 5.95, // Preço simulado
              );
              
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Compra de 10 BYD registrada!'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          _buildCircularAction(
            icon: Icons.trending_down,
            label: 'Vender',
            onTap: () {
              final controller = TextEditingController();
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Vender Tokens BYD'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Quantidade de BYD para vender:'),
                      const SizedBox(height: 16),
                      TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Quantidade',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final quantidade = controller.text;
                        if (quantidade.isNotEmpty) {
                          // Registrar venda no histórico usando o serviço simples
                          SimpleTransactionService().addTransaction(
                            type: 'VENDA',
                            amount: quantidade,
                            price: 6.09, // Preço de venda simulado
                          );
                          
                          Navigator.pop(context);
                          
                          // Mostrar confirmação
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Venda de $quantidade BYD registrada!'),
                              backgroundColor: Colors.green,
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                      child: const Text('Vender'),
                    ),
                  ],
                ),
              );
            },
          ),
          _buildCircularAction(icon: Icons.swap_horiz, label: 'Trocar', onTap: () {}),
          _buildCircularAction(icon: Icons.send, label: 'Enviar', onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildTransactionTile(String title, String sub, String value, IconData icon, Color iconColor) { // Função que cria cada linha da lista de transações.
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 22), // Ícone representativo da transação.
          const SizedBox(width: 15),
          Expanded( // Faz os textos ocuparem o meio da tela, empurrando o valor para o fim.
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)), // Nome da transação.
                Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 11)), // Endereço ou detalhes da transação.
              ],
            ),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)), // Valor transacionado.
        ],
      ),
    );
  }

  
  Widget _buildBottomNav(BuildContext context, Color activeColor) { // Função que constrói a barra de navegação flutuante e escura.
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20), // Define as margens para a barra não encostar nas bordas.
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF222222), // Cor de fundo grafite da barra.
        borderRadius: BorderRadius.circular(40), // Arredonda totalmente as pontas da barra.
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espaça os ícones do menu igualmente.
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoutes.catalogo),
            child: const Icon(Icons.home_filled, color: Colors.white70), // Ícone da página inicial.
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoutes.balcao),
            child: const Icon(Icons.account_balance, color: Colors.white70), // Ícone do balcão.
          ),
          Container( // Widget que destaca o botão da aba atual (Carteira).
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: activeColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.account_balance_wallet, color: Colors.white, size: 20), // Ícone de carteira.
                SizedBox(width: 8),
                Text('Carteira', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), // Texto da aba ativa.
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoutes.historico),
            child: const Icon(Icons.history, color: Colors.white70), // Ícone de histórico.
          ),
        ],
      ),
    );
  }
}
