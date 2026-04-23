import 'package:flutter/material.dart';
import 'app_storage.dart';

class CarteiraBalcaoScreen extends StatefulWidget {
  const CarteiraBalcaoScreen({super.key});

  @override
  State<CarteiraBalcaoScreen> createState() => _CarteiraBalcaoScreenState();
}

class _CarteiraBalcaoScreenState extends State<CarteiraBalcaoScreen> {
  double _balance = 0;
  List<Map<String, dynamic>> _transacoes = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final balance = await AppStorage.getWalletBalance();
    final txs = await AppStorage.getWalletTransactions();
    if (!mounted) return;
    setState(() {
      _balance = balance;
      _transacoes = txs;
      _loading = false;
    });
  }

  void _onActionTap(String label) {
    if (label == 'Investir') {
      final updated = <Map<String, dynamic>>[
        {
          'title': 'Compra',
          'value': '-10.00 BYD',
        },
        ..._transacoes,
      ];
      setState(() {
        _balance += 10;
        _transacoes = updated;
      });
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$label em desenvolvimento')));
  }

  @override
  Widget build(BuildContext context) {
    const Color roxoPrincipal = Color(0xFF6B4FD8);
    const Color fundoBranco = Colors.white;

    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: fundoBranco,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Voltar',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 13),
                      children: [
                        TextSpan(
                          text: '\$1.297,67  ',
                          style: TextStyle(color: Colors.black54),
                        ),
                        TextSpan(
                          text: '+0.75%',
                          style: TextStyle(
                            color: Color(0xFF00C896),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'BYD',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${_balance.toStringAsFixed(2)} BYD',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    color: roxoPrincipal,
                  ),
                ),
                Text(
                  'R\$ ${(_balance * 6.1).toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCircularAction(Icons.analytics_outlined, 'Investir'),
              _buildCircularAction(Icons.swap_horiz_rounded, 'Trocar'),
              _buildCircularAction(Icons.send_rounded, 'Enviar'),
              _buildCircularAction(Icons.south_west_rounded, 'Receber'),
            ],
          ),
          const SizedBox(height: 35),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hoje',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: ListView.separated(
                      itemCount: _transacoes.length,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1, color: Color(0xFFF0F0F0)),
                      itemBuilder: (context, index) {
                        final item = _transacoes[index];
                        return _buildTransactionItem(item);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(roxoPrincipal),
    );
  }

  Widget _buildCircularAction(IconData icon, String label) {
    return GestureDetector(
      onTap: () => _onActionTap(label),
      child: Column(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: const BoxDecoration(
              color: Color(0xFFF2F2F2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.black, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> item) {
    bool isNeg = item['value'].toString().contains('-');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFE8F5E9),
            radius: 20,
            child: Icon(
              isNeg ? Icons.shopping_cart_outlined : Icons.south_west,
              size: 18,
              color: const Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'To: 0x18dcc0e...e2bf7c64...',
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Text(
            item['value'],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(Color activeColor) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(35),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(Icons.home_filled, color: Colors.white, size: 28),
            const Icon(Icons.search, color: Colors.white54, size: 28),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF4C3592),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Balcão',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/profile-security'),
              child: const CircleAvatar(
                radius: 14,
                backgroundColor: Colors.white24,
                child: Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
