import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/simple_transaction_service.dart';

class ValuationDashboardScreen extends StatefulWidget {
  const ValuationDashboardScreen({super.key});

  @override
  State<ValuationDashboardScreen> createState() => _ValuationDashboardScreenState();
}

class _ValuationDashboardScreenState extends State<ValuationDashboardScreen> {
  String _selectedStartup = '5bfozOLJ0a93No2wuWni'; // BYD
  String _selectedPeriod = 'daily';
  bool _isLoading = true;
  final _transactionService = SimpleTransactionService();

  @override
  void initState() {
    super.initState();
    _loadValuationData();
    
    // Inicializar dados se necessário
    if (_transactionService.transactions.isEmpty) {
      _transactionService.initializeSampleData();
    }
    
    // Escutar mudanças nas transações
    _transactionService.transactionsNotifier.addListener(_updateValuationData);
  }

  @override
  void dispose() {
    _transactionService.transactionsNotifier.removeListener(_updateValuationData);
    super.dispose();
  }

  void _updateValuationData() {
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadValuationData() async {
    // Usar dados reais do serviço compartilhado
    _updateValuationData();
  }

  String _formatDate(String dateStr) {
    final date = DateTime.parse(dateStr);
    return DateFormat('dd/MM').format(date);
  }

  @override
  Widget build(BuildContext context) {
    const Color roxoMescla = Color(0xFF512DA8);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Dashboard de Valorização'),
        backgroundColor: roxoMescla,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadValuationData,
              child: ValueListenableBuilder<List<Map<String, dynamic>>>(
                valueListenable: _transactionService.transactionsNotifier,
                builder: (context, transactions, child) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Seletores
                        _buildSelectors(),
                        const SizedBox(height: 24),

                        // Estatísticas principais (reativas)
                        _buildMainStatistics(),
                        const SizedBox(height: 24),

                        // Gráfico de preços simplificado (reativo)
                        _buildSimplePriceChart(),
                        const SizedBox(height: 24),

                        // Gráfico de volume simplificado (reativo)
                        _buildSimpleVolumeChart(),
                        const SizedBox(height: 24),

                        // Estatísticas detalhadas (reativas)
                        _buildDetailedStatistics(),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }

  Widget _buildSelectors() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Período',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildPeriodChip('Diário', 'daily'),
              const SizedBox(width: 8),
              _buildPeriodChip('Semanal', 'weekly'),
              const SizedBox(width: 8),
              _buildPeriodChip('Mensal', 'monthly'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodChip(String label, String value) {
    final isSelected = _selectedPeriod == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() => _selectedPeriod = value);
        _loadValuationData();
      },
      backgroundColor: Colors.grey[200],
      selectedColor: const Color(0xFF512DA8).withOpacity(0.2),
      labelStyle: TextStyle(
        color: isSelected ? const Color(0xFF512DA8) : Colors.black,
      ),
    );
  }

  Widget _buildMainStatistics() {
    final statistics = _transactionService.getStatistics();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Estatísticas das Transações',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Preço Médio',
                  'R\$ ${statistics['avgPrice'].toStringAsFixed(2)}',
                  Icons.trending_up,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Volume Total',
                  'R\$ ${statistics['totalVolume']}',
                  Icons.account_balance,
                  Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimplePriceChart() {
    final transactions = _transactionService.transactions;
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Histórico de Preços das Transações',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                final isPositive = transaction['type'] == 'COMPRA';
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isPositive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction['type'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isPositive ? Colors.green : Colors.red,
                            ),
                          ),
                          Text(
                            _formatDate(transaction['timestamp']),
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            isPositive ? Icons.trending_up : Icons.trending_down,
                            color: isPositive ? Colors.green : Colors.red,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'R\$ ${transaction['price'].toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isPositive ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleVolumeChart() {
    final transactions = _transactionService.transactions;
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Volume de Transações',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Row(
              children: transactions.map((transaction) {
                final maxVolume = transactions.map((t) => double.parse(t['amount'])).reduce((a, b) => a > b ? a : b);
                final height = (double.parse(transaction['amount']) / maxVolume) * 120;
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    height: height,
                    decoration: BoxDecoration(
                      color: transaction['type'] == 'COMPRA' ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        transaction['amount'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedStatistics() {
    final statistics = _transactionService.getStatistics();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Resumo das Transações',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildDetailStat('Total Transações', '${statistics['totalTransactions']}'),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDetailStat('Volume Total', 'R\$ ${statistics['totalVolume']}'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
