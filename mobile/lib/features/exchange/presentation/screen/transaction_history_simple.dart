import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/simple_transaction_service.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  final _transactionService = SimpleTransactionService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    // Inicializar dados se necessário
    if (_transactionService.transactions.isEmpty) {
      _transactionService.initializeSampleData();
    }
    setState(() {
      _isLoading = false;
    });
  }

  String _formatDate(String timestamp) {
    final date = DateTime.parse(timestamp);
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }

  String _formatCurrency(String value) {
    return 'R\$ ${double.parse(value).toStringAsFixed(2)}';
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'VENDA':
        return Colors.red;
      case 'COMPRA':
        return Colors.green;
      case 'TRANSFERENCIA':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'VENDA':
        return Icons.trending_down;
      case 'COMPRA':
        return Icons.trending_up;
      case 'TRANSFERENCIA':
        return Icons.swap_horiz;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color roxoMescla = Color(0xFF512DA8);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Histórico de Transações'),
        backgroundColor: roxoMescla,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                _initializeData();
              },
              child: Column(
                children: [
                  // Estatísticas
                  _buildStatistics(),
                  const SizedBox(height: 16),
                  
                  // Lista de transações
                  Expanded(
                    child: _buildTransactionList(),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildStatistics() {
    final statistics = _transactionService.getStatistics();
    return Container(
      margin: const EdgeInsets.all(16),
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
            'Resumo',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  'Total Transações',
                  '${statistics['totalTransactions']}',
                  Icons.receipt,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatItem(
                  'Volume Total',
                  _formatCurrency(statistics['totalVolume']),
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

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
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
            label,
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

  Widget _buildTransactionList() {
    return ValueListenableBuilder<List<Map<String, dynamic>>>(
      valueListenable: _transactionService.transactionsNotifier,
      builder: (context, transactions, child) {
        if (transactions.isEmpty) {
          return const Center(
            child: Text(
              'Nenhuma transação encontrada',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return _buildTransactionCard(transaction);
          },
        );
      },
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> transaction) {
    final typeColor = _getTypeColor(transaction['type']);
    final typeIcon = _getTypeIcon(transaction['type']);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          // Cabeçalho
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: typeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  typeIcon,
                  color: typeColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction['type'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: typeColor,
                      ),
                    ),
                    Text(
                      _formatDate(transaction['timestamp']),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: transaction['status'] == 'COMPLETA' 
                      ? Colors.green.withOpacity(0.1)
                      : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  transaction['status'],
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: transaction['status'] == 'COMPLETA' 
                        ? Colors.green
                        : Colors.orange,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Detalhes da transação
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quantidade',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    '${transaction['amount']} BYD',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    _formatCurrency(transaction['total']),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          // Preço unitário
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Preço unitário: ',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                _formatCurrency(transaction['price'].toString()),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
