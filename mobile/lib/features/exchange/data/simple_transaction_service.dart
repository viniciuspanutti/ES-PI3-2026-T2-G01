import 'package:flutter/material.dart';

class SimpleTransactionService {
  static final SimpleTransactionService _instance = SimpleTransactionService._internal();
  factory SimpleTransactionService() => _instance;
  SimpleTransactionService._internal();

  final List<Map<String, dynamic>> _transactions = [];
  final _transactionsNotifier = ValueNotifier<List<Map<String, dynamic>>>([]);

  ValueNotifier<List<Map<String, dynamic>>> get transactionsNotifier => _transactionsNotifier;
  List<Map<String, dynamic>> get transactions => List.from(_transactionsNotifier.value);

  void addTransaction({
    required String type,
    required String amount,
    required double price,
  }) {
    final agora = DateTime.now();
    final transaction = {
      'id': agora.millisecondsSinceEpoch.toString(),
      'type': type, // 'COMPRA' ou 'VENDA'
      'amount': amount, // quantidade de tokens
      'timestamp': agora.toIso8601String(), // data e hora exata
      'status': 'COMPLETA',
      'price': price,
      'total': (double.parse(amount) * price).toStringAsFixed(2),
    };

    _transactions.insert(0, transaction); // Adiciona no início (mais recente primeiro)
    
    // Atualizar o ValueNotifier com a lista completa
    _transactionsNotifier.value = List.from(_transactions);
  }

  void initializeSampleData() {
    // Dados iniciais apenas para demonstração
    _transactions.addAll([
      {
        'id': '1',
        'type': 'COMPRA',
        'amount': '25',
        'timestamp': DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
        'status': 'COMPLETA',
        'price': 5.95,
        'total': '148.75',
      },
      {
        'id': '2',
        'type': 'VENDA',
        'amount': '10',
        'timestamp': DateTime.now().subtract(const Duration(hours: 1)).toIso8601String(),
        'status': 'COMPLETA',
        'price': 6.09,
        'total': '60.90',
      },
    ]);
    _transactionsNotifier.value = List.from(_transactions);
  }

  Map<String, dynamic> getStatistics() {
    if (_transactions.isEmpty) {
      return {
        'totalTransactions': 0,
        'totalVolume': '0.00',
        'avgPrice': 0.0,
      };
    }

    final totalVolume = _transactions.fold<double>(
      0.0, 
      (sum, transaction) => sum + double.parse(transaction['total'].toString())
    );

    final avgPrice = _transactions.fold<double>(
      0.0, 
      (sum, transaction) => sum + transaction['price']
    ) / _transactions.length;

    return {
      'totalTransactions': _transactions.length,
      'totalVolume': totalVolume.toStringAsFixed(2),
      'avgPrice': avgPrice,
    };
  }
}
