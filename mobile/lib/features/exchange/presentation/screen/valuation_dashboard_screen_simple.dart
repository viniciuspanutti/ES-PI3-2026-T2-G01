import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../data/simple_transaction_service.dart';

class ValuationDashboardScreen extends StatefulWidget {
  const ValuationDashboardScreen({super.key});

  @override
  State<ValuationDashboardScreen> createState() => _ValuationDashboardScreenState();
}

class _ValuationDashboardScreenState extends State<ValuationDashboardScreen> {
  String _selectedPeriod = 'MENSAL';
  final _transactionService = SimpleTransactionService();

  // Cores personalizadas para um estilo "Deep Blue / Emerald" único
  final Color primaryColor = const Color(0xFF0F172A); // Azul muito escuro (Slate 900)
  final Color accentColor = const Color(0xFF10B981); // Verde Esmeralda vibrante
  final Color cardColor = Colors.white;
  final Color backgroundColor = const Color(0xFFF1F5F9); // Cinza azulado bem claro

  @override
  void initState() {
    super.initState();
    if (_transactionService.transactions.isEmpty) {
      _transactionService.initializeSampleData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: primaryColor, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Minha Performance',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.w800, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: _transactionService.transactionsNotifier,
        builder: (context, transactions, child) {
          final stats = _transactionService.getStatistics();
          
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                
                // Card de Saldo com Design "Glassmorphism" simplificado
                _buildModernBalanceCard(stats['totalVolume']),
                
                const SizedBox(height: 30),
                
                // Seção do Gráfico com bordas mais suaves e estilo "Neumorphism" leve
                _buildEvolutionSection(transactions),
                
                const SizedBox(height: 30),
                
                // Grid de Estatísticas Rápidas
                _buildQuickStatsGrid(stats),
                
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildModernBalanceCard(String total) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          image: const NetworkImage('https://www.transparenttextures.com/patterns/carbon-fibre.png'),
          opacity: 0.05,
          repeat: ImageRepeat.repeat,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'VALOR TOTAL EM CUSTÓDIA',
                style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1.5),
              ),
              Icon(Icons.account_balance_wallet_outlined, color: accentColor, size: 20),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'R\$ $total',
            style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: -0.5),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: accentColor.withOpacity(0.5)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.arrow_upward, color: accentColor, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '14.2%',
                      style: TextStyle(color: accentColor, fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'vs. mês anterior',
                style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEvolutionSection(List<Map<String, dynamic>> transactions) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Evolução',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1E293B)),
              ),
              _buildSimplePeriodDropdown(),
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 220,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey.withOpacity(0.1),
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value % 5000 == 0) {
                          return Text('${value ~/ 1000}k', style: TextStyle(color: Colors.grey[400], fontSize: 10));
                        }
                        return const SizedBox();
                      },
                      reservedSize: 30,
                    ),
                  ),
                  bottomTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: _generateChartSpots(transactions),
                    isCurved: true,
                    curveSmoothness: 0.4,
                    color: accentColor,
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                        radius: 4,
                        color: Colors.white,
                        strokeWidth: 3,
                        strokeColor: accentColor,
                      ),
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [accentColor.withOpacity(0.15), accentColor.withOpacity(0.0)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimplePeriodDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            _selectedPeriod,
            style: TextStyle(color: primaryColor, fontSize: 11, fontWeight: FontWeight.bold),
          ),
          Icon(Icons.keyboard_arrow_down, color: primaryColor, size: 16),
        ],
      ),
    );
  }

  Widget _buildQuickStatsGrid(Map<String, dynamic> stats) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.4,
      children: [
        _buildMinimalStatCard('Transações', '${stats['totalTransactions']}', Icons.swap_vert, Colors.blue),
        _buildMinimalStatCard('Preço Médio', 'R\$ ${stats['avgPrice'].toStringAsFixed(2)}', Icons.analytics_outlined, Colors.orange),
        _buildMinimalStatCard('Volume', 'R\$ ${stats['totalVolume']}', Icons.pie_chart_outline, Colors.purple),
        _buildMinimalStatCard('Status', 'Ativo', Icons.check_circle_outline, Colors.green),
      ],
    );
  }

  Widget _buildMinimalStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 11, fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text(value, style: TextStyle(color: primaryColor, fontSize: 15, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }

  List<FlSpot> _generateChartSpots(List<Map<String, dynamic>> transactions) {
    if (transactions.isEmpty) return [const FlSpot(0, 4500), const FlSpot(7, 4500)];
    double currentVolume = 4500;
    List<FlSpot> spots = [FlSpot(0, currentVolume)];
    for (int i = 0; i < transactions.length && i < 7; i++) {
      final tx = transactions[transactions.length - 1 - i];
      final amount = double.parse(tx['total']);
      currentVolume += (tx['type'] == 'COMPRA' ? amount : -amount);
      spots.add(FlSpot((i + 1).toDouble(), currentVolume));
    }
    while (spots.length <= 7) spots.add(FlSpot(spots.length.toDouble(), currentVolume));
    return spots;
  }
}
