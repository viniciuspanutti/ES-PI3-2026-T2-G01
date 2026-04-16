import 'package:flutter/material.dart';

class CarteiraBalcaoScreen extends StatelessWidget {
  
  const CarteiraBalcaoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    const Color roxoMescla = Color(0xFF512DA8); 
    const Color fundoCinza = Color(0xFFF5F5F5);

    return Scaffold(
      backgroundColor: fundoCinza,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Voltar', style: TextStyle(color: Colors.black, fontSize: 18)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header com Variação e Logo BYD do Figma
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text('\$1.297,67  +0.75%', 
                      style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
                  const SizedBox(height: 10),
                  const Text('BYD', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, letterSpacing: 2)),
                  const SizedBox(height: 10),
                  const Text('345.71 BYD', 
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: roxoMescla)),
                  Text('R\$ 2.107,34', style: TextStyle(color: Colors.grey[600], fontSize: 16)),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Botões de Ação 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCircularAction(Icons.show_chart, 'Comprar'),
                _buildCircularAction(Icons.swap_horiz, 'Trocar'),
                _buildCircularAction(Icons.send, 'Enviar'),
                _buildCircularAction(Icons.file_download, 'Receber'),
              ],
            ),

            const SizedBox(height: 40),

            // Histórico de Transações
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Hoje', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 20),
                  _buildTransactionTile('Transferencia', 'To: 0x38dc...b037', '93 BYD', Icons.send, Colors.greenAccent),
                  _buildTransactionTile('Compra', 'To: 0x7131...8b6a', '23.4 BYD', Icons.shopping_cart, Colors.greenAccent),
                  _buildTransactionTile('Recebido', 'Address: 0x4d1e...c37C', '57 BYD', Icons.swap_vert, Colors.greenAccent),
                  _buildTransactionTile('Recebido', 'To: 0x38dc...b037', '12.2 BYD', Icons.send, Colors.greenAccent),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(roxoMescla),
    );
  }

  Widget _buildCircularAction(IconData icon, String label) {
    return Column(
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
    );
  }

  Widget _buildTransactionTile(String title, String sub, String value, IconData icon, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        ],
      ),
    );
  }

  Widget _buildBottomNav(Color activeColor) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF222222),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.home_filled, color: Colors.white70),
          const Icon(Icons.search, color: Colors.white70),
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
