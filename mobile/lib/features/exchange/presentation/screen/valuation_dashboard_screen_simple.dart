
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

  // Cores: Tema "Deep Graphite & Neon Emerald"
  final Color primaryColor = const Color(0xFF10B981); // Emerald vibrante
  final Color backgroundColor = const Color(0xFF0F172A); // Slate 900
  final Color cardColor = const Color(0xFF1E293B); // Slate 800

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
        title: const Text('PERFORMANCE', 
          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 2)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: _transactionService.transactionsNotifier,
        builder: (context, transactions, child) {
          final stats = _transactionService.getStatistics();
          
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                
                // Card de Saldo Limpo (SEM BOTÕES)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [cardColor, cardColor.withOpacity(0.8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('SALDO TOTAL INVESTIDO', 
                        style: TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
                      const SizedBox(height: 12),
                      Text(
                        'R\$ ${stats['totalVolume']}',
                        style: const TextStyle(color: Colors.white, fontSize: 38, fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: primaryColor.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.trending_up, color: primaryColor, size: 16),
                            const SizedBox(width: 6),
                            Text('+14.2% ESTE MÊS', 
                              style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                
                const Text('EVOLUÇÃO DE SALDO', 
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
                
                const SizedBox(height: 24),
                
                // Seção do Gráfico com Seletores LADO A LADO
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Seletores na VERTICAL (ao lado do gráfico)
                    Column(
                      children: ['DIÁRIO', 'SEMANAL', 'MENSAL', '6 MESES'].map((p) {
                        final isSelected = _selectedPeriod == p;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedPeriod = p),
                          child: Container(
                            width: 80,
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor : cardColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: isSelected ? primaryColor : Colors.white10),
                            ),
                            child: Center(
                              child: Text(
                                p.split(' ')[0], // Pega apenas a primeira palavra
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.white38,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    
                    const SizedBox(width: 16),
                    
                    // O Gráfico
                    Expanded(
                      child: Container(
                        height: 280,
                        padding: const EdgeInsets.only(top: 20, right: 10),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: LineChart(
                          LineChartData(
                            gridData: FlGridData(
                              show: true,
                              getDrawingHorizontalLine: (value) => FlLine(color: Colors.white.withOpacity(0.05), strokeWidth: 1),
                              drawVerticalLine: false,
                            ),
                            titlesData: const FlTitlesData(show: false),
                            borderData: FlBorderData(show: false),
                            lineBarsData: [
                              LineChartBarData(
                                spots: _generateChartSpots(transactions),
                                isCurved: true,
                                color: primaryColor,
                                barWidth: 4,
                                isStrokeCapRound: true,
                                dotData: FlDotData(
                                  show: true,
                                  getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                                    radius: 4,
                                    color: backgroundColor,
                                    strokeWidth: 2,
                                    strokeColor: primaryColor,
                                  ),
                                ),
                                belowBarData: BarAreaData(
                                  show: true,
                                  gradient: LinearGradient(
                                    colors: [primaryColor.withOpacity(0.2), primaryColor.withOpacity(0.0)],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Tiles de Dados no Final
                _buildSimpleDataRow('Volume de Transações', 'R\$ ${stats['totalVolume']}', Icons.bar_chart),
                const SizedBox(height: 12),
                _buildSimpleDataRow('Preço Médio Pago', 'R\$ ${stats['avgPrice'].toStringAsFixed(2)}', Icons.payments),
                
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSimpleDataRow(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 24),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.white38, fontSize: 11)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
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
