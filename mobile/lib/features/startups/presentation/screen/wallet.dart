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
  static const double _bydToBrl = 6.09;
  static const List<Map<String, dynamic>> _startups = [
    {
      'name': 'AgroTrace',
      'stage': 'Em operação',
      'description': 'Rastreabilidade de alimentos com IoT',
      'capital': 'R\$ 420.000,00',
      'tokens': 120000,
      'priceByd': 2.5,
    },
    {
      'name': 'SaudeAI',
      'stage': 'Nova',
      'description': 'Triagem inteligente para clínicas populares',
      'capital': 'R\$ 95.000,00',
      'tokens': 80000,
      'priceByd': 1.6,
    },
    {
      'name': 'LogX',
      'stage': 'Em expansão',
      'description': 'Otimização de rotas para entregas urbanas',
      'capital': 'R\$ 1.120.000,00',
      'tokens': 300000,
      'priceByd': 3.8,
    },
  ];

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

  Future<void> _persistWalletState() async {
    await AppStorage.setWalletBalance(_balance);
    await AppStorage.setWalletTransactions(_transacoes);
  }

  Future<void> _registerTransaction({
    required String title,
    required String subtitle,
    required double amountByd,
    required bool isCredit,
    required String kind,
  }) async {
    final signedAmount = isCredit ? amountByd : -amountByd;
    final nextBalance = _balance + signedAmount;
    if (!isCredit && nextBalance < 0) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saldo insuficiente para essa operacao')),
      );
      return;
    }

    setState(() {
      _balance = nextBalance;
      _transacoes.insert(0, {
        'title': title,
        'subtitle': subtitle,
        'value':
            '${isCredit ? '+' : '-'}${amountByd.toStringAsFixed(2)} BYD',
        'kind': kind,
      });
    });
    await _persistWalletState();
  }

  Future<void> _onInvest() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Catalogo de startups',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ..._startups.map((startup) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Text(startup['name'] as String),
                      subtitle: Text(
                        '${startup['stage']} • ${startup['description']}',
                      ),
                      trailing: Text(
                        '${(startup['priceByd'] as double).toStringAsFixed(2)} BYD',
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        _onBuyTokens(startup);
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _onBuyTokens(Map<String, dynamic> startup) async {
    final tokenController = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        final unitPrice = startup['priceByd'] as double;
        return AlertDialog(
          title: Text('Comprar tokens • ${startup['name']}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Estagio: ${startup['stage']}'),
              Text('Capital aportado: ${startup['capital']}'),
              Text('Tokens emitidos: ${startup['tokens']}'),
              const SizedBox(height: 12),
              Text('Preco por token: ${unitPrice.toStringAsFixed(2)} BYD'),
              const SizedBox(height: 8),
              TextField(
                controller: tokenController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Quantidade de tokens',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Confirmar compra'),
            ),
          ],
        );
      },
    );

    final qty = int.tryParse(tokenController.text.trim()) ?? 0;
    tokenController.dispose();
    if (confirmed != true || qty <= 0) return;

    final total = qty * (startup['priceByd'] as double);
    await _registerTransaction(
      title: 'Compra de tokens',
      subtitle: '${startup['name']} • $qty tokens',
      amountByd: total,
      isCredit: false,
      kind: 'buy',
    );
  }

  Future<void> _onReceive() async {
    final amountController = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adicionar saldo ficticio'),
        content: TextField(
          controller: amountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Valor em R\$',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );

    final brl = double.tryParse(amountController.text.replaceAll(',', '.')) ?? 0;
    amountController.dispose();
    if (confirmed != true || brl <= 0) return;

    final byd = brl / _bydToBrl;
    await _registerTransaction(
      title: 'Recarga simulada',
      subtitle: 'Credito interno da plataforma',
      amountByd: byd,
      isCredit: true,
      kind: 'deposit',
    );
  }

  Future<void> _onSend() async {
    final amountController = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enviar BYD'),
        content: TextField(
          controller: amountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Valor em BYD',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Enviar'),
          ),
        ],
      ),
    );

    final byd = double.tryParse(amountController.text.replaceAll(',', '.')) ?? 0;
    amountController.dispose();
    if (confirmed != true || byd <= 0) return;

    await _registerTransaction(
      title: 'Transferencia enviada',
      subtitle: 'Envio para carteira externa',
      amountByd: byd,
      isCredit: false,
      kind: 'send',
    );
  }

  Future<void> _onSwap() async {
    final amountController = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Trocar ativos'),
        content: TextField(
          controller: amountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Quantidade de BYD para trocar',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Trocar'),
          ),
        ],
      ),
    );

    final byd = double.tryParse(amountController.text.replaceAll(',', '.')) ?? 0;
    amountController.dispose();
    if (confirmed != true || byd <= 0) return;

    await _registerTransaction(
      title: 'Troca de ativos',
      subtitle: 'Conversao simulada BYD -> MSC',
      amountByd: byd,
      isCredit: false,
      kind: 'swap',
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color roxoPrincipal = Color(0xFF6B4FD8);

    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: roxoPrincipal)),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Voltar',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
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
                const SizedBox(height: 10),
                const Text(
                  'BYD',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -2,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${_balance.toStringAsFixed(2)} BYD',
                  style: const TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: roxoPrincipal,
                  ),
                ),
                Text(
                  'R\$ ${(_balance * 6.09).toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.black45,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCircularAction(
                Icons.bar_chart_rounded,
                'Investir',
                onTap: _onInvest,
              ),
              _buildCircularAction(
                Icons.swap_horiz_rounded,
                'Trocar',
                onTap: _onSwap,
              ),
              _buildCircularAction(Icons.send_rounded, 'Enviar', onTap: _onSend),
              _buildCircularAction(
                Icons.download_rounded,
                'Receber',
                onTap: _onReceive,
              ),
            ],
          ),
          const SizedBox(height: 40),
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
                      color: Colors.black38,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.separated(
                      itemCount: _transacoes.length,
                      separatorBuilder: (_, unusedIndex) => const Divider(
                        height: 25,
                        color: Color(0xFFF5F5F5),
                      ),
                      itemBuilder: (context, index) =>
                          _buildTransactionItem(context, _transacoes[index]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildCircularAction(IconData icon, String label, {VoidCallback? onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: onTap,
      child: Column(
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: const BoxDecoration(
            color: Color(0xFFF6F6F6),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.black, size: 26),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context, Map<String, dynamic> item) {
    bool isNeg = item['value'].toString().contains('-');
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TransactionDetailScreen(
              title: item['title'],
              value: item['value'],
            ),
          ),
        );
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFF1FDF5),
            radius: 22,
            child: Icon(
              isNeg ? Icons.shopping_cart_outlined : Icons.south_west_rounded,
              size: 20,
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
                const Text(
                  'To: 0x18dcc0e...e2bf7c64...',
                  style: TextStyle(color: Colors.black38, fontSize: 12),
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

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.only(bottom: 25, left: 20, right: 20),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(35),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: _onInvest,
              icon: const Icon(Icons.home_filled, color: Colors.white, size: 26),
            ),
            IconButton(
              onPressed: _onInvest,
              icon: const Icon(Icons.search, color: Colors.white54, size: 26),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF5A36BF),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Row(
                children: [
                  Icon(Icons.account_balance_wallet,
                      color: Colors.white, size: 18),
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
            IconButton(
              onPressed: () => Navigator.pushNamed(context, '/profile-security'),
              icon: const Icon(
                Icons.person_outline,
                color: Colors.white54,
                size: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// TELA DE DETALHES (TransactionDetailScreen)
class TransactionDetailScreen extends StatelessWidget {
  final String title;
  final String value;

  const TransactionDetailScreen({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Voltar',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'BYD',
              style: TextStyle(fontSize: 46, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 10),
            Text(
              value.replaceAll('-', ''),
              style: const TextStyle(
                fontSize: 34,
                color: Color(0xFF6B4FD8),
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'R\$ 2.107,34',
              style: TextStyle(color: Colors.black45, fontSize: 16),
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFF0F0F0)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [
                  _DetailRow(label: 'Date', value: 'Dec 24, 09:41 AM'),
                  Divider(height: 20),
                  _DetailRow(label: 'Status', value: 'Completed'),
                  Divider(height: 20),
                  _DetailRow(label: 'Quem Recebeu', value: '0x1d6dcc...d037'),
                  Divider(height: 20),
                  _DetailRow(label: 'Taxa', value: '0,02 ETH (\$20.35)'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Ver mais detalhes',
                style: TextStyle(
                  color: Color(0xFF6B4FD8),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.black45)),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ],
    );
  }
}
