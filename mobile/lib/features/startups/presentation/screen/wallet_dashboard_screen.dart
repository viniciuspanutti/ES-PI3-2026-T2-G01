import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_storage.dart';

class WalletDashboardPage extends StatefulWidget {
  const WalletDashboardPage({super.key});

  @override
  State<WalletDashboardPage> createState() => _WalletDashboardPageState();
}

class _WalletDashboardPageState extends State<WalletDashboardPage> {
  String selectedPeriod = 'M';
  double _saldoByd = 0;
  List<Map<String, dynamic>> _transacoes = [];
  bool _loading = true;
  int _currentIndex = 1;
  final TextEditingController _aporteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCarteira();
  }

  @override
  void dispose() {
    _aporteController.dispose();
    super.dispose();
  }

  Future<void> _loadCarteira() async {
    final saldo = await AppStorage.getWalletBalance();
    final txs = await AppStorage.getWalletTransactions();

    if (!mounted) return;
    setState(() {
      _saldoByd = saldo;
      _transacoes = txs;
      _loading = false;
    });
  }

  Future<void> _persistCarteira() async {
    await AppStorage.setWalletBalance(_saldoByd);
    await AppStorage.setWalletTransactions(_transacoes);
  }

  Future<void> _adicionarSaldo() async {
    _aporteController.clear();
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Adicionar saldo'),
        content: TextField(
          controller: _aporteController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            hintText: 'Ex: 50.00',
            labelText: 'Quantidade (BYD)',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              final valor = double.tryParse(
                    _aporteController.text.trim().replaceAll(',', '.'),
                  ) ??
                  0;
              if (valor <= 0) {
                if (!dialogContext.mounted) return;
                ScaffoldMessenger.of(dialogContext).showSnackBar(
                  const SnackBar(content: Text('Informe um valor válido.')),
                );
                return;
              }

              setState(() {
                _saldoByd += valor;
                _transacoes.insert(0, {
                  'title': 'Aporte manual',
                  'subtitle': 'Saldo adicionado pela carteira',
                  'value': '+${valor.toStringAsFixed(2)} BYD',
                  'kind': 'deposit',
                  'createdAt': DateTime.now().toIso8601String(),
                });
              });
              await _persistCarteira();
              if (!dialogContext.mounted) return;
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(dialogContext).showSnackBar(
                const SnackBar(content: Text('Saldo adicionado com sucesso!')),
              );
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  void _mostrarStartupsInvestidas() {
    final ativos = _transacoes
        .map((tx) => tx['title']?.toString() ?? '')
        .where((title) => title.isNotEmpty)
        .toSet()
        .toList();
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ativos.isEmpty
              ? const Text('Nenhum ativo encontrado.')
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Meus ativos',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ...ativos.map(
                      (nome) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.pie_chart_outline),
                        title: Text(nome),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> _abrirBalcao() async {
    await Navigator.pushNamed(context, '/balcao');
    if (!mounted) return;
    await _loadCarteira();
  }

  void _onBottomTap(int index) {
    setState(() => _currentIndex = index);
    if (index == 2) {
      _abrirBalcao();
      return;
    }
    if (index == 3) {
      Navigator.pushNamed(context, '/profile-security');
      return;
    }
    if (index == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Você já está na área principal.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final spots = _getHistoricoPrecos(selectedPeriod);
    final variacao = _formatVariacao(spots);

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBFF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 60,
                left: 24,
                right: 24,
                bottom: 40,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF4B0082),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'PATRIMÔNIO ESTIMADO',
                    style: GoogleFonts.montserrat(
                      color: Colors.white60,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'R\$ ${(_saldoByd * 6.10).toStringAsFixed(2)}',
                    style: GoogleFonts.philosopher(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Rendimento: $variacao',
                      style: const TextStyle(
                        color: Color(0xFF4B0082),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionBtn(
                        'Recarregar',
                        Icons.account_balance_wallet_outlined,
                        _adicionarSaldo,
                      ),
                      _buildActionBtn(
                        'Meus Ativos',
                        Icons.pie_chart_outline,
                        _mostrarStartupsInvestidas,
                      ),
                      _buildActionBtn('Negociar', Icons.sync_alt, _abrirBalcao),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Histórico de Valorização',
                    style: GoogleFonts.montserrat(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildPeriodSelector(),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 180,
                    child: LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: false),
                        titlesData: const FlTitlesData(show: false),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: spots,
                            isCurved: false,
                            color: const Color(0xFF4B0082),
                            barWidth: 3,
                            dotData: const FlDotData(show: true),
                            belowBarData: BarAreaData(
                              show: true,
                              color: const Color(0xFF4B0082).withValues(alpha: 0.05),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Movimentações Recentes',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  if (_transacoes.isEmpty)
                    const Center(child: Text('Sem ordens registradas.'))
                  else
                    ..._transacoes.take(3).map(_itemTransacaoCustom),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF4B0082),
        unselectedItemColor: Colors.grey,
        onTap: _onBottomTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'Carteira',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_outlined),
            label: 'Balcão',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn(String title, IconData icon, VoidCallback action) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: action,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(16),
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF4B0082),
            elevation: 2,
          ),
          child: Icon(icon, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildPeriodSelector() {
    final periods = ['D', 'S', 'M', '6M', 'YTD'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: periods
            .map(
              (p) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => setState(() => selectedPeriod = p),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: selectedPeriod == p
                          ? const Color(0xFF4B0082)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: selectedPeriod == p
                            ? Colors.transparent
                            : Colors.grey[300]!,
                      ),
                    ),
                    child: Text(
                      p,
                      style: TextStyle(
                        color: selectedPeriod == p ? Colors.white : Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _itemTransacaoCustom(Map<String, dynamic> tx) {
    final valor = tx['value']?.toString() ?? '';
    final isPositive = valor.contains('+');
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            size: 10,
            color: isPositive ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              tx['title'] ?? 'Ordem',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            valor,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  List<FlSpot> _getHistoricoPrecos(String period) {
    if (period == 'D') {
      return const [FlSpot(0, 6.0), FlSpot(1, 6.08), FlSpot(2, 6.10)];
    }
    return const [FlSpot(0, 5.7), FlSpot(1, 5.9), FlSpot(2, 6.10)];
  }

  String _formatVariacao(List<FlSpot> spots) {
    if (spots.isEmpty) return '0.00%';
    final ini = spots.first.y;
    final fim = spots.last.y;
    final res = ((fim - ini) / ini) * 100;
    return '${res >= 0 ? '+' : ''}${res.toStringAsFixed(2)}%';
  }
}
